package com.github.damianmcdonald.kettledemo;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Controller
public class MappableAttributeController {

    @Autowired
    private MappableAttributeRepository repository;

    @GetMapping("/status")
    public String getStatus (final Map<String, Object> model) throws JsonProcessingException {
        model.put("mappableAttributes", repository.findAll());
        return "status";
    }

    @GetMapping("/public-attributes")
    public @ResponseBody String getPublicAttributes () throws JsonProcessingException {
        Set<Tuple3> values = repository
                .findByPublicAttribute()
                .stream()
                .map(m -> new Tuple3(m.getApplicationNumber(), m.getAttributeName(), m.getAttributeValue())
                ).collect(Collectors.toSet());
        return new ObjectMapper().writerWithDefaultPrettyPrinter().writeValueAsString(values);
    }

    class Tuple3 {
        private final String applicationNumber;
        private final String attributeName;
        private final String attributeValue;

        public Tuple3(final String applicationNumber, final String attributeName, final String attributeValue) {
            this.applicationNumber = applicationNumber;
            this.attributeName = attributeName;
            this.attributeValue = attributeValue;
        }

        public String getApplicationNumber() {
            return applicationNumber;
        }

        public String getAttributeName() {
            return attributeName;
        }

        public String getAttributeValue() {
            return attributeValue;
        }
    }
}
