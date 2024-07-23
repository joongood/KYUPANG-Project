package com.kyupang.model;

import java.util.Date;

import lombok.Data;

@Data
public class VisitorStats {
	private Date visitDate;
	private String ipAddress;
    private int visitorCount;
}
