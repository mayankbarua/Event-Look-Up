package com.webtools.Dao;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import com.webtools.exception.UserException;
import com.webtools.pojo.User;

public class UserDAO extends DAO {
	public void register(User user) throws UserException {
		try {
			Session session = getSession();
			begin();
			session.save(user);
			commit();
		} catch (HibernateException e) {
			rollback();
			throw new UserException("Exception while user register: " + e.getMessage());
		}
	}

	public User authenticate(User user) throws UserException {
		User u = null;
		try {
			Session session = getSession();
			begin();
			Criteria criteria = session.createCriteria(User.class);
			criteria.add(Restrictions.eq("userEmail", user.getUserEmail()));
			criteria.add(Restrictions.eq("password", user.getPassword()));
			u = (User) criteria.uniqueResult();
			commit();
		} catch (HibernateException e) {
			rollback();
			throw new UserException("Exception while user authenticate: " + e.getMessage());
		}
		return u;
	}

	public long update(User user) throws UserException {
		long result = 0;
		try {
			Session session = getSession();
			begin();
			Query query = session.createQuery(
					"update User set firstName = :firstName, lastName = :lastName, password = :password where userEmail = :userEmail");
			query.setString("firstName", user.getFirstName());
			query.setString("lastName", user.getLastName());
			query.setString("password", user.getPassword());
			query.setString("userEmail", user.getUserEmail());
			result = query.executeUpdate();
			commit();
		} catch (HibernateException e) {
			rollback();
			throw new UserException("Exception while user update: " + e.getMessage());
		}
		return result;
	}

	public User checkEmailId(String email) throws UserException {
		User user = null;
		try {
			Session session = getSession();
			begin();
			Criteria criteria = session.createCriteria(User.class);
			criteria.add(Restrictions.eq("userEmail", email));
			user = (User) criteria.uniqueResult();
			commit();
		} catch (HibernateException e) {
			rollback();
			throw new UserException("Exception while user checkEmail: " + e.getMessage());
		}
		return user;
	}
}
