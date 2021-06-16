package ac.kr.jejunu.mashup;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(value = "/board")
public class BoardController {

    @Autowired BoardRepository boardRepository;

    @GetMapping(value = "/get/{id}")
    public Board get(@PathVariable int id) {
        return boardRepository.findById(id).get();
    }

    @GetMapping(value = "/get/boards")
    public List<Board> list() {
        return boardRepository.findAll();
    }

    @PostMapping(value = "/post")
    public void save(@ModelAttribute Board board) {
        Board check = boardRepository.save(board);
        System.out.println(check);
    }

    @DeleteMapping(value = "/delete/{id}")
    public void delete(@PathVariable int id) {
        boardRepository.deleteById(id);
        System.out.println("Delete done");
    }
}