package com.example.demo.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;


import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.service.LoginTestService;
import com.example.demo.vo.LoginTestVO;


@Controller
public class HomeController {
	
	@Autowired
	LoginTestService service;
	
	
	@RequestMapping(value = "/")
	public String main(LoginTestVO vo) throws Exception {
		return "main";
	}
	
	@RequestMapping(value="/getUserInfo")
	 @ResponseBody public LoginTestVO getUserInfo(HttpServletRequest request) throws Exception {

		LoginTestVO vo = new LoginTestVO();
		String userId = request.getParameter("userId");

		vo.setUserId(userId);
		
		/* 일부러 오류 발생
		if (true) {
			throw new Exception("에러 발생!!!");
		}
		*/	
		return service.getUserInfo2(vo);
	}
	

	  @RequestMapping(value="/formContents")
	  @ResponseBody public LoginTestVO formContents(HttpServletRequest request) throws Exception {
		  	
		  LoginTestVO vo = new LoginTestVO(); 
		  String userId = request.getParameter("userId");
		 
		  System.out.println(userId + "컨트롤러에서 확인");	
		  vo.setUserId(userId);
		  	
		  return service.getUserInfo2(vo); 
	  }
	 


	 

	@RequestMapping(value = "/login")
	public String login(LoginTestVO vo, HttpServletRequest request, HttpServletResponse response, RedirectAttributes rttr) throws Exception {
		HttpSession session= request.getSession();
		LoginTestVO login = service.login(vo);
		
		
		
		if(login == null) {//만약에 틀렸으면 로그인 실패 페이지 보여주기
			session.setAttribute("member",null); // 세션에 member라는 변수 추가해주고 그 값을 null로 설정해준다.
			rttr.addFlashAttribute("msg", false);
			
		}
		else {
			//디비까지 가서 맞는 정보 넣은건지 확인해서 맞으면 
			//session.setAttribute("userId", vo.getUserId());
			//String userId = (String) session.getAttribute("userId"); // 자료형이 일정치 않아서 스트링으로 형변환 해줘야함
			//service.register(vo);
			session.setAttribute("member", login);
			
			//이렇게 띄워주고 로그인 성공 페이지 보여주기
		}
		return "redirect:/";
	}
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) throws Exception{
		
		session.invalidate();
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "/register")
	public String register(LoginTestVO vo) throws Exception {
		return "register"; //register.jsp로 넘겨준다
	}
	
	@RequestMapping(value = "/registerForm")
	public String registerForm(LoginTestVO vo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		service.register(vo); //컨트롤러 -> 서비스 (-> dao-> db -> dao-> 서비스-> 컨트롤러) // 넣고오라고 시킨거임.
	
		request.setAttribute("userId", vo.getUserId()); // 제대로 넣고왔는지 HttpServletRequest로 확인가능!
		// vo.getUerId() 로 가져온 값을 userId에 setting 해준다.
		
		return "result"; // 이렇게 페이지를 반환하면서 ^ 위에서 받은 userId값은 result.jsp에서 <% String userId = request.getParameter("userId"); %>로 자바문 써서 사용가능!
		
		//HttpServletRequest는 vo 안에 있는 것들 항목 하나씩 값들 가져올수잇게함
		//HttpServletRequest 헤더, 쿠키 정보같은거 설정해서 보낼 수 있게함
	}
	
 
	
//	@RequestMapping(value = "/member/register", method = RequestMethod.GET)
//	public String getRegister(LoginTestVO vo) throws Exception {
//		return "register";
//	}
//	
//	// 회원가입 post
//	@RequestMapping(value = "/member/register", method = RequestMethod.POST)
//	public void postRegister(LoginTestVO vo) throws Exception {
//		service.register(vo);
//	}
	
	

}



