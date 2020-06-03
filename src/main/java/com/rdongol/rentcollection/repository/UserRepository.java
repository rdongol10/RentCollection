package com.rdongol.rentcollection.repository;

import org.springframework.data.repository.CrudRepository;
import com.rdongol.rentcollection.model.User;

public interface UserRepository extends CrudRepository<User, Long> {

	boolean existsUserByLoginName(String loginName);

	User findUserByLoginName(String loginName);
}
