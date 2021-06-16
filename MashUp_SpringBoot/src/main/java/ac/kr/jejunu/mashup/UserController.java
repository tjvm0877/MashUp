package ac.kr.jejunu.mashup;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(value = "/user")
public class UserController {

    @Autowired UserRepository userRepository;

    @PostMapping(value = "/signup")
    public void login(@ModelAttribute Users users) {
        userRepository.save(users);
    }

    @PostMapping(value = "/login")
    public Boolean login(String userid, String password) {
        return userRepository.findByUseridAndPassword(userid, password).isPresent();
    }
}
