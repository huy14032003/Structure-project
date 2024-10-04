package com.foxconn.fii.main.data.primary.repository;

import com.foxconn.fii.main.data.primary.model.entity.TmpText;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TmpTextRepository extends JpaRepository<TmpText, Integer> {

    List<TmpText> findByFileName(String fileName);

}

