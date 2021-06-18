package ac.kr.jejunu.mashup;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(value = "/board")
public class BoardController {

    @Autowired BoardRepository boardRepository;

    @GetMapping(value = "/get/{id}")
    public Board getById(@PathVariable int id) {
        return boardRepository.findById(id).get();
    }

    @GetMapping(value = "/get/boards")
    public List<Board> list() {
        return boardRepository.findAll();
    }

    @GetMapping(value = "/get/category/{category}")
    public List<Board> list(@PathVariable int category) {
        return boardRepository.findByCategory(category); }

    @PostMapping(value = "/post")
    public void save(@RequestBody Board board) {
        System.out.println(board.toString());
        Board check = boardRepository.save(board);
        System.out.println(check);
    }

    @DeleteMapping(value = "/delete/{id}")
    public void delete(@PathVariable int id) {
        boardRepository.deleteById(id);
        System.out.println("Delete done");
    }
}
