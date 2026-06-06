package com.example.jiudianruzhu.mapper;

import com.example.jiudianruzhu.entity.RoomType;
import org.apache.ibatis.annotations.*;

import java.time.LocalDate;
import java.util.List;

public interface RoomTypeMapper {
    @Select("select * from room_type order by create_time desc")
    List<RoomType> findAll();

    @Select("<script>select * from room_type where status=1 " +
            "<if test='category!=null and category!=\"\"'>and category=#{category}</if>" +
            "<if test='keyword!=null and keyword!=\"\"'>and (type_name like concat('%',#{keyword},'%') or facilities like concat('%',#{keyword},'%') or tags like concat('%',#{keyword},'%'))</if>" +
            "<if test='minPrice!=null'>and price &gt;= #{minPrice}</if>" +
            "<if test='maxPrice!=null'>and price &lt;= #{maxPrice}</if>" +
            "<if test='sort==\"rating\"'>order by rating desc, price asc</if>" +
            "<if test='sort==\"priceDesc\"'>order by price desc</if>" +
            "<if test='sort==\"priceAsc\" or sort==null or sort==\"\"'>order by price asc</if>" +
            "</script>")
    List<RoomType> findOnline(@Param("category") String category,
                              @Param("keyword") String keyword,
                              @Param("sort") String sort,
                              @Param("minPrice") Integer minPrice,
                              @Param("maxPrice") Integer maxPrice);

    @Select("select * from room_type where id=#{id}")
    RoomType findById(Long id);

    @Insert("insert into room_type(type_name,category,image_url,price,original_price,star_level,rating,distance_text,bed_type,capacity,breakfast,facilities,tags,promotion,description,status,create_time) values(#{typeName},#{category},#{imageUrl},#{price},#{originalPrice},#{starLevel},#{rating},#{distanceText},#{bedType},#{capacity},#{breakfast},#{facilities},#{tags},#{promotion},#{description},#{status},now())")
    int insert(RoomType roomType);

    @Update("update room_type set type_name=#{typeName},category=#{category},image_url=#{imageUrl},price=#{price},original_price=#{originalPrice},star_level=#{starLevel},rating=#{rating},distance_text=#{distanceText},bed_type=#{bedType},capacity=#{capacity},breakfast=#{breakfast},facilities=#{facilities},tags=#{tags},promotion=#{promotion},description=#{description},status=#{status} where id=#{id}")
    int update(RoomType roomType);

    @Delete("delete from room_type where id=#{id}")
    int delete(Long id);

    @Update("update room_type set status=#{status} where id=#{id}")
    int updateStatus(@Param("id") Long id, @Param("status") Integer status);

    @Select("select count(*) from room r where r.room_type_id=#{roomTypeId} and r.status='FREE' and r.id not in (" +
            "select ifnull(o.room_id,0) from booking_order o where o.room_type_id=#{roomTypeId} and o.status in ('BOOKED','CHECKED_IN') " +
            "and not (o.checkout_date <= #{checkinDate} or o.checkin_date >= #{checkoutDate}))")
    int countAvailable(@Param("roomTypeId") Long roomTypeId, @Param("checkinDate") LocalDate checkinDate, @Param("checkoutDate") LocalDate checkoutDate);
}
