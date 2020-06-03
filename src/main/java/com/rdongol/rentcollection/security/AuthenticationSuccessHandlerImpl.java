package com.rdongol.rentcollection.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.rdongol.rentcollection.model.User;

@Component
public class AuthenticationSuccessHandlerImpl implements AuthenticationSuccessHandler {

	@Autowired
	HttpSession session;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {

		String userName = authentication.getName();

		User loggedInUser = ((UserDetailsImpl) authentication.getPrincipal()).getUser();
		session.setAttribute("userId", userName);
		session.setAttribute("userName", loggedInUser.getFirstName() + " " + loggedInUser.getLastName());
		response.sendRedirect(request.getContextPath() + "/");

	}

}
