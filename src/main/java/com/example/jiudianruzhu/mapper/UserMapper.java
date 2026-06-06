package com.example.jiudianruzhu.mapper;

import com.example.jiudianruzhu.entity.User;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface UserMapper {
    @Select("select * from sys_user where username=#{account} or phone=#{account} limit 1")
    User findByAccount(String account);

    @Select("select * from sys_user where username=#{username} or phone=#{phone} limit 1")
    User findDuplicate(@Param("username") String username, @Param("phone") String phone);

    @Insert("insert into sys_user(username,password,real_name,phone,id_card,status,create_time) values(#{username},#{password},#{realName},#{phone},#{idCard},1,now())")
    int insert(User user);

    @Update("update sys_user set real_name=#{realName},phone=#{phone},id_card=#{idCard} where id=#{id}")
    int updateProfile(User user);

    @Update("update sys_user set password=#{password} where id=#{id}")
    int updatePassword(@Param("id") Long id, @Param("password") String password);

    @Select("select u.*, count(o.id) consume_count from sys_user u left join booking_order o on u.id=o.user_id and o.status='COMPLETED' group by u.id order by u.create_time desc")
    List<User> findAllWithConsumeCount();

    @Update("update sys_user set status=#{status} where id=#{id}")
    int updateStatus(@Param("id") Long id, @Param("status") Integer status);

    @Update("update sys_user set login_error_count=#{loginErrorCount}, lock_time=#{lockTime} where id=#{id}")
    int updateLoginLock(User user);

    @Update("update sys_user set login_error_count=0, lock_time=null where id=#{id}")
    int clearLock(Long id);
}
