package com.rdongol.rentcollection.controller;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rdongol.rentcollection.model.PasswordResetToken;
import com.rdongol.rentcollection.model.User;
import com.rdongol.rentcollection.service.PasswordResetTokenService;
import com.rdongol.rentcollection.service.UserService;

@Controller
public class LoginController {

	@Autowired
	private UserService userService;

	@Autowired
	private PasswordResetTokenService passwordResetTokenService;

	@Autowired
	private JavaMailSender mailSender;

	@RequestMapping("/login")
	public String loginPAge() {
		return "login";
	}

	@RequestMapping("/forgetPassword")
	public String forgetPassword() {
		return "forgetPassword";
	}
	
	@RequestMapping("/savePassword")
	public String savePassword(Model model ,HttpServletRequest request) {
		
		String token =request.getParameter("token");
		String password = request.getParameter("password");
		if(passwordResetTokenService.isValidToken(token)) {
			PasswordResetToken passwordResetToken =passwordResetTokenService.findByToken(token);
			User user = passwordResetToken.getUser();
			user.setPassword(password);
			userService.save(user);
			model.addAttribute("successmessage", "Password Updated");

		}else {
			model.addAttribute("errorMessage", "Token Expired");
		}
		return "login";
	}
	
	@PostMapping("/resetpassword")
	@ResponseBody
	public ResponseEntity<Map<String, String>> requestResetPassword(HttpServletRequest request, @RequestParam String email) {

		User user = userService.findUserByEmailAddress(email);
		Map<String, String> responseMap = new HashMap<String, String>();

		if (user == null) {
			responseMap.put("message", "No user with the email");
			responseMap.put("result", "fail");
			return ResponseEntity.ok(responseMap);
		}

		String token = UUID.randomUUID().toString();
		passwordResetTokenService.createPasswordResetToken(user, token);
		mailSender.send(constructResetTokenEmail(getAppUrl(request), request.getLocale(), token, user));

		responseMap.put("message", "Reset email is sent to you");
		responseMap.put("result", "true");
		return ResponseEntity.ok(responseMap);
	}
	
	
	@GetMapping("/changePassword")
	public String showChagePasswordPage(Model model, @RequestParam("token") String token) {
		
		if(!passwordResetTokenService.isValidToken(token)){
			model.addAttribute("errormessage", "Token Expired");
			return "login";
		}
		return "resetPassword";
	}

	private SimpleMailMessage constructResetTokenEmail(String contextPath, Locale locale, String token, User user) {
		final String url = contextPath + "/changePassword?token=" + token;
		final String message = "Please goto following link and reset your password. The link will work only for next 24 hours";
		return constructEmail("Reset Password", message + " \r\n" + url, user);
	}

	private SimpleMailMessage constructEmail(String subject, String body, User user) {
		final SimpleMailMessage email = new SimpleMailMessage();
		email.setSubject(subject);
		email.setText(body);
		email.setTo(user.getEmailAddress());
		email.setFrom("rawbean08@gmail.com");
		return email;
	}

	private String getAppUrl(HttpServletRequest request) {
		return "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
	}
	
	
	

}
