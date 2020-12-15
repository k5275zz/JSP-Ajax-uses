package user;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/UserSerachServlet")
public class UserSerachServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userName = request.getParameter("userName");
		response.getWriter().write(getJSON(userName));
		
	}
	
	// 요청한 결과가 json형태로 결과를 응답한다.
	public String getJSON(String userName) {
		 if(userName == null) userName ="";
		 StringBuffer result = new StringBuffer("");
		 result.append("{\"result\":[");
		 UserDAO userdao = new UserDAO();
		 ArrayList<User> userList = userdao.search(userName);
		 
		 for(int i =0;i<userList.size();i++) {
			 result.append("[{\"value\":\""+userList.get(i).getUserName()+"\"},");
			 result.append("{\"value\":\""+userList.get(i).getUserAge()+"\"},");
			 result.append("{\"value\":\""+userList.get(i).getUserGender()+"\"},");
			 result.append("{\"value\":\""+userList.get(i).getUserEmail()+"\"}],");
		 }
		 result.append("]}");
		 return result.toString();
	}
	
	// 유저 등록 로직
	

}
