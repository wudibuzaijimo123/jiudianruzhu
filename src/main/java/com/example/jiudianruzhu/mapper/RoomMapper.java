package com.example.jiudianruzhu.mapper;

import com.example.jiudianruzhu.entity.Room;
import org.apache.ibatis.annotations.*;

import java.time.LocalDate;
import java.util.List;

public interface RoomMapper {
    @Select("select r.*, rt.type_name from room r left join room_type rt on r.room_type_id=rt.id order by r.room_no")
    List<Room> findAll();

    @Select("select * from room where id=#{id}")
    Room findById(Long id);

    @Insert("insert into room(room_type_id,room_no,floor_no,status) values(#{roomTypeId},#{roomNo},#{floorNo},#{status})")
    int insert(Room room);

    @Update("update room set room_type_id=#{roomTypeId},room_no=#{roomNo},floor_no=#{floorNo},status=#{status} where id=#{id}")
    int update(Room room);

    @Update("update room set status=#{status} where id=#{id}")
    int updateStatus(@Param("id") Long id, @Param("status") String status);

    @Delete("delete from room where id=#{id}")
    int delete(Long id);

    @Select("select r.* from room r where r.room_type_id=#{roomTypeId} and r.status='FREE' and r.id not in (" +
            "select ifnull(o.room_id,0) from booking_order o where o.room_type_id=#{roomTypeId} and o.status in ('BOOKED','CHECKED_IN') " +
            "and not (o.checkout_date <= #{checkinDate} or o.checkin_date >= #{checkoutDate})) limit 1")
    Room findAvailable(@Param("roomTypeId") Long roomTypeId, @Param("checkinDate") LocalDate checkinDate, @Param("checkoutDate") LocalDate checkoutDate);
}
