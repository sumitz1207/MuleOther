import javafx.animation.AnimationTimer;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.layout.StackPane;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.scene.canvas.Canvas;
import javafx.scene.canvas.GraphicsContext;
import javafx.stage.Stage;

public class Main extends Application {
    Rectangle rect;
    GraphicsContext gc;
    final int HEIGHT = 480;
    final int WIDTH = 640;
    Screen current;

    @Override
    public void start(Stage primaryStage) {
        StackPane root = new StackPane();
        Scene scene = new Scene(root, WIDTH, HEIGHT);
        Canvas canvas = new Canvas(WIDTH, HEIGHT);
        root.getChildren().add(canvas);
        gc = canvas.getGraphicsContext2D();
        current = new ConfigScreen(this, scene);
        new AnimationTimer() {
            public void handle(long gt) {
                render(gc);
            }
        }.start();
        primaryStage.setTitle("MULE");
        primaryStage.setScene(scene);
        primaryStage.show();
    }

    public void render(GraphicsContext gc) {
        gc.setFill(Color.WHITE);
        gc.fillRect(0, 0, WIDTH, HEIGHT);
        current.draw(gc, WIDTH, HEIGHT);
        gc.setFill(Color.BLACK);
    }


    public void switchScreen(Screen screen) {
        current = screen;
    }

    public static void main(String[] args) {
        launch(args);
    }
}
