package com.example.jiudianruzhu.mapper;

import com.example.jiudianruzhu.entity.BookingOrder;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface BookingOrderMapper {
    @Select("select o.*, u.username, u.phone user_phone, rt.type_name, r.room_no from booking_order o left join sys_user u on o.user_id=u.id left join room_type rt on o.room_type_id=rt.id left join room r on o.room_id=r.id where o.user_id=#{userId} order by o.create_time desc")
    List<BookingOrder> findByUser(Long userId);

    @Select("<script>select o.*, u.username, u.phone user_phone, rt.type_name, r.room_no from booking_order o left join sys_user u on o.user_id=u.id left join room_type rt on o.room_type_id=rt.id left join room r on o.room_id=r.id where 1=1 " +
            "<if test='keyword!=null and keyword!=\"\"'>and (o.order_no like concat('%',#{keyword},'%') or u.phone like concat('%',#{keyword},'%') or o.guest_name like concat('%',#{keyword},'%'))</if>" +
            "<if test='status!=null and status!=\"\"'>and o.status=#{status}</if> order by o.create_time desc</script>")
    List<BookingOrder> search(@Param("keyword") String keyword, @Param("status") String status);

    @Select("select o.*, rt.type_name, r.room_no from booking_order o left join room_type rt on o.room_type_id=rt.id left join room r on o.room_id=r.id where o.id=#{id}")
    BookingOrder findById(Long id);

    @Insert("insert into booking_order(order_no,user_id,room_type_id,room_id,guest_name,guest_id_card,guest_phone,checkin_date,checkout_date,nights,total_amount,status,create_time) values(#{orderNo},#{userId},#{roomTypeId},#{roomId},#{guestName},#{guestIdCard},#{guestPhone},#{checkinDate},#{checkoutDate},#{nights},#{totalAmount},#{status},now())")
    int insert(BookingOrder order);

    @Select("select count(*) from booking_order where user_id=#{userId} and room_type_id=#{roomTypeId} and status in ('BOOKED','CHECKED_IN') " +
            "and not (checkout_date <= #{checkinDate} or checkin_date >= #{checkoutDate})")
    int countUserConflict(BookingOrder order);

    @Update("update booking_order set status=#{status} where id=#{id}")
    int updateStatus(@Param("id") Long id, @Param("status") String status);

    @Update("update booking_order set room_id=#{roomId}, status='CHECKED_IN' where id=#{id}")
    int checkIn(@Param("id") Long id, @Param("roomId") Long roomId);
}
