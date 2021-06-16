package ac.kr.jejunu.mashup;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class MashUpApplicationTests {

    @Autowired
    BoardRepository boardRepository;

    @Test
    void contextLoads() {
    }

    @Test
    public void insert(){
        Board board = new Board();
        board.setTitle("왓챠 같이 보실분~~");
        board.setContent("사람 구함~");
        board.setHeadcount(1);
        board.setMax(4);
        boardRepository.save(board);
    }
}
