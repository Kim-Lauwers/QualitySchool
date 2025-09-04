package be.qualityschool.service;

import java.util.Map;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Minimalistische service: bewust eenvoudig zodat een AI-agent hierop kan
 * verbeteren (betere foutafhandeling, custom exceptions, extra tests, ...).
 */
public class UserService {
    private static final Logger log = LoggerFactory.getLogger(UserService.class);

    private final Map<String, User> inMemory =
            Map.of("42", new User("42", "Kim"), "7", new User("7", "Ada"));

    /** Zoekt een user. Retourneert Optional.empty bij null/unknown id. */
    public Optional<User> findById(String id) {
        if (id == null || id.isBlank()) {
            log.warn("findById called with null/blank id");
            return Optional.empty();
        }
        return Optional.ofNullable(inMemory.get(id));
    }
}
