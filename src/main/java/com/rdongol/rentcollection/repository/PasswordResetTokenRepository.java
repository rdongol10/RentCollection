package com.rdongol.rentcollection.repository;

import org.springframework.data.repository.CrudRepository;

import com.rdongol.rentcollection.model.PasswordResetToken;

public interface PasswordResetTokenRepository extends CrudRepository<PasswordResetToken, Long> {
	PasswordResetToken findByToken(String token);
}
