package com.foxconn.fii.main.data.primary.repository;


import com.foxconn.fii.main.data.primary.model.entity.SopAgile;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SopAgileRepository extends JpaRepository<SopAgile, SopAgile.SopAgileKey> {

    @Query(value = "SELECT mas.* \n" +
            "from mfAgileSOPMapping mas \n" +
            "WHERE mas.ITEM_number like ?1\n", nativeQuery = true)
    List<SopAgile> getSopAgileMapping(String sopCode);

}
