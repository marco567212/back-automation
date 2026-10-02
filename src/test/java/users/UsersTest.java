package users;

import io.karatelabs.junit6.Karate;
import org.junit.jupiter.api.DynamicNode;

class UsersTest {

    @Karate.Test
    Iterable<DynamicNode> testUsers() {
        return Karate.run().relativeTo(getClass());
    }
}
