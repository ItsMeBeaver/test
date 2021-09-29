package com.example.demo.service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.example.demo.dao.*;
import com.example.demo.vo.*;

@Service
@Repository
public class LoginTestServiceImpl implements LoginTestService {
	
	@Autowired LoginTestDao dao;
	
	@Override
	public void register(LoginTestVO vo) throws Exception {
		dao.register(vo);
	}
	@Override
	public LoginTestVO login(LoginTestVO vo) throws Exception {
		return dao.login(vo);
	}
	@Override
	public LoginTestVO getUserInfo2(LoginTestVO vo) {
		//서비스에서 임의의 값을 지정해줄수도 있고 여러가지 가능함!
		
		LoginTestVO result = dao.getUserInfo3(vo);
		
		System.out.print(result.toString());
		
		return result;
	}


}