package com.laptrinhjavaweb.entity;


import javax.persistence.*;

@Entity
@Table(name = "rentarea")
public class RentareaEntity extends BaseEntity{

    @Column(name = "value")
    private String value;

    @ManyToOne
    @JoinColumn(name = "buildingid", nullable = false)
    private BuildingEntity building;

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public BuildingEntity getBuilding() {
        return building;
    }

    public void setBuilding(BuildingEntity building) {
        this.building = building;
    }
}
