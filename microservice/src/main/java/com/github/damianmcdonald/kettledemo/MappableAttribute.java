package com.github.damianmcdonald.kettledemo;

import javax.persistence.*;

@Entity
@Table(name="ip_entity_attrs")
public class MappableAttribute {

    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Long id;

    @Column(name = "entity_id")
    private Long entityId;

    @Column(name = "application_number")
    private String applicationNumber;

    @Column(name = "attr_name")
    private String attributeName;

    @Column(name = "attr_val")
    private String attributeValue;

    @Column(name = "isPublished")
    private boolean isPublished;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getEntityId() {
        return entityId;
    }

    public void setEntityId(Long entityId) {
        this.entityId = entityId;
    }

    public String getApplicationNumber() {
        return applicationNumber;
    }

    public void setApplicationNumber(String applicationNumber) {
        this.applicationNumber = applicationNumber;
    }

    public String getAttributeName() {
        return attributeName;
    }

    public void setAttributeName(String attributeName) {
        this.attributeName = attributeName;
    }

    public String getAttributeValue() {
        return attributeValue;
    }

    public void setAttributeValue(String attributeValue) {
        this.attributeValue = attributeValue;
    }

    public boolean isPublished() {
        return isPublished;
    }

    // hack for Thymeleaf - get prefix required
    public boolean getIsPublished() {
        return isPublished;
    }

    public void setPublished(boolean isPublished) {
        this.isPublished = isPublished;
    }

}
