/**
 */
public class Player {
    String name;
    pColor color;
    Race race;
    
    public Player() {
        name = "";
    }
    public void setColor(pColor color) {
        this.color = color;
    }
    public PlayerColor getColor() {
        return this.color;
    }
    public void setRace(Race race) {
        this.race = race;
    }
    public Race getRace() {
        return this.race;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getName() {
        return this.name;
    }
}
