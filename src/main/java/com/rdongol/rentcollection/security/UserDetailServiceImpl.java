package com.rdongol.rentcollection.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.rdongol.rentcollection.model.User;
import com.rdongol.rentcollection.service.UserService;

@Service
public class UserDetailServiceImpl implements UserDetailsService {

	@Autowired
	private UserService userSrvice;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

		User user = userSrvice.findUserByUserName(username);
		if (user == null) {
			throw new UsernameNotFoundException("User xaina yesto");
		}
		return new UserDetailsImpl(user);
	}

}
