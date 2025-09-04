package be.qualityschool.service;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.Optional;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class UserServiceTest {

    @Test
    @DisplayName("findById returns user for known id")
    void findByIdKnown() {
        var svc = new UserService();
        Optional<User> u = svc.findById("42");
        assertThat(u).isPresent();
        assertThat(u.get().name()).isEqualTo("Kim");
    }

    @Test
    @DisplayName("findById returns empty for unknown/null/blank")
    void findByIdUnknownOrNull() {
        var svc = new UserService();
        assertThat(svc.findById("999")).isEmpty();
        assertThat(svc.findById(null)).isEmpty();
        assertThat(svc.findById("  ")).isEmpty();
    }
}
