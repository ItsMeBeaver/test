package com.example.demo.service;
import org.springframework.stereotype.Service;

import com.example.demo.vo.*;

@Service
public interface LoginTestService{
	public void register(LoginTestVO vo) throws Exception;
	
	public LoginTestVO login(LoginTestVO vo)throws Exception;
	
	public LoginTestVO getUserInfo2(LoginTestVO vo);

	
}