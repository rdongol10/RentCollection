package com.rdongol.rentcollection.service;

import java.util.Calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rdongol.rentcollection.model.PasswordResetToken;
import com.rdongol.rentcollection.model.User;
import com.rdongol.rentcollection.repository.PasswordResetTokenRepository;

@Service
public class PasswordResetTokenService {

	@Autowired
	private PasswordResetTokenRepository passwordResetTokenRepository;

	public PasswordResetToken save(PasswordResetToken passwordResetToken) {
		return passwordResetTokenRepository.save(passwordResetToken);
	}

	public PasswordResetToken findByToken(String token) {
		return passwordResetTokenRepository.findByToken(token);
	}

	public boolean isTokenExpired(PasswordResetToken passwordResetToken) {
		Calendar cal = Calendar.getInstance();
		return passwordResetToken.getExpiryDate().before(cal.getTime());
	}

	public void createPasswordResetToken(User user, String token) {
		PasswordResetToken passwordResetToken = new PasswordResetToken(token, user);
		save(passwordResetToken);
	}

	public void deletePasswordResetToken(PasswordResetToken passwordResetToken) {
		passwordResetTokenRepository.delete(passwordResetToken);
	}
	
	public boolean isValidToken(String token) {
		PasswordResetToken passwordResetToken = findByToken(token);

		if (passwordResetToken == null) {
			return false;
		}

		return !isTokenExpired(passwordResetToken);
	}

}
