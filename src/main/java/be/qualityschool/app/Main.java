package be.qualityschool.app;

import be.qualityschool.service.User;
import be.qualityschool.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Main {
    private static final Logger log = LoggerFactory.getLogger(Main.class);

    public static void main(String[] args) {
        log.info("Starting application");
        var svc = new UserService();
        var maybe = svc.findById("42");
        maybe.ifPresentOrElse(
                u -> log.info("Hello, {}!", u.name()),
                () -> log.warn("No user found"));
    }
}
