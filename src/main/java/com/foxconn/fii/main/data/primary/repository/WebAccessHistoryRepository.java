package com.foxconn.fii.main.data.primary.repository;

import com.foxconn.fii.main.data.primary.model.entity.WebAccessHistory;
import org.springframework.data.jpa.repository.JpaRepository;

public interface WebAccessHistoryRepository extends JpaRepository<WebAccessHistory, Integer> {

}

