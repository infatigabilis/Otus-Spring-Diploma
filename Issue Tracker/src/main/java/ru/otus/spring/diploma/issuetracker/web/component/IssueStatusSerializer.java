package ru.otus.spring.diploma.issuetracker.web.component;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.ser.std.StdSerializer;
import lombok.val;
import ru.otus.spring.diploma.issuetracker.domain.IssueStatus;

import java.io.IOException;

public class IssueStatusSerializer extends StdSerializer<IssueStatus> {

    public IssueStatusSerializer() {
        super(IssueStatus.class);
    }

    @Override
    public void serialize(IssueStatus issueStatus, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
        jsonGenerator.writeStartObject();

        jsonGenerator.writeStringField("current", issueStatus.name());

        jsonGenerator.writeArrayFieldStart("next");
        for (val status : issueStatus.getNext()) {
            jsonGenerator.writeObject(status.name());
        }
        jsonGenerator.writeEndArray();

        jsonGenerator.writeArrayFieldStart("previous");
        for (val status : issueStatus.getPrevious()) {
            jsonGenerator.writeString(status.name());
        }
        jsonGenerator.writeEndArray();

        jsonGenerator.writeEndObject();
    }
}
