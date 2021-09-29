package com.example.demo.dao;
import org.apache.ibatis.annotations.Mapper;


import com.example.demo.vo.LoginTestVO;

@Mapper
public interface LoginTestDao{
	public void register(LoginTestVO vo) throws Exception;
	
	public LoginTestVO login(LoginTestVO vo) throws Exception;

	public LoginTestVO getUserInfo3(LoginTestVO vo);

}