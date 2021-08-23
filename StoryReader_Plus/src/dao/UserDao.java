package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.User;

public class UserDao {
	public static User findUser(Connection con, String user_input_id, String user_input_pw) throws SQLException {
		PreparedStatement pstmt = null;
		User user = new User();
		try {
			con.setAutoCommit(false);
			pstmt = con.prepareStatement("SELECT user_login_pw FROM user WHERE user_login_id = ?");
			pstmt.setString(1, user_input_id);
			ResultSet rs = pstmt.executeQuery();
			con.commit();
			con.setAutoCommit(true);
			
			if(rs.next()) { //existing user
				String user_login_pw = rs.getString(3);
				if(user_login_pw.equals(user_input_pw)) { //login success
					//fill user model
					user.setUserId(rs.getInt(1));
					user.setUserLoginId(rs.getString(2));
					user.setUserLoginPw(rs.getString(3));
					user.setUserName(rs.getString(4));
					return user;
				}
				else { //login failed
					return null;
				}
			}
			else { //invalid user
				return null;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {pstmt.close(); }
		}
		return null;
	}

}
