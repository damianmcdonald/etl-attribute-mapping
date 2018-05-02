package com.github.damianmcdonald.kettledemo;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface MappableAttributeRepository extends CrudRepository<MappableAttribute, Long> {

    @Query("select m from MappableAttribute m where m.isPublished = true")
    public List<MappableAttribute> findByPublicAttribute();
}
