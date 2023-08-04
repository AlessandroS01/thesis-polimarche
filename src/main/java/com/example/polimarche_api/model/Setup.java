package com.example.polimarche_api.model;

import com.example.polimarche_api.model.records.NewSetup;
import jakarta.persistence.*;

import java.util.List;
import java.util.Objects;

@Entity
@Table(name = "setup")
public class Setup {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(name = "ala_anteriore")
    private String ala;
    private String note;

    @ManyToOne
    @JoinColumn(name = "gomma_ant_dx")
    private Wheel wheelAntDx;
    @ManyToOne
    @JoinColumn(name = "gomma_ant_sx")
    private Wheel wheelAntSx;
    @ManyToOne
    @JoinColumn(name = "gomma_post_dx")
    private Wheel wheelPostDx;
    @ManyToOne
    @JoinColumn(name = "gomma_post_sx")
    private Wheel wheelPostSx;

    @ManyToOne
    @JoinColumn(name = "bilanciamento_ant")
    private Balance balanceAnt;
    @ManyToOne
    @JoinColumn(name = "bilanciamento_post")
    private Balance balancePost;

    @ManyToOne
    @JoinColumn(name = "molla_ant")
    private Spring springAnt;
    @ManyToOne
    @JoinColumn(name = "molla_post")
    private Spring springPost;

    @ManyToOne
    @JoinColumn(name = "ammortizzatore_ant")
    private Damper damperAnt;
    @ManyToOne
    @JoinColumn(name = "ammortizzatore_post")
    private Damper damperPost;

    public Setup(Integer id,
                 String ala,
                 String note,
                 Wheel wheelAntDx,
                 Wheel wheelAntSx,
                 Wheel wheelPostDx,
                 Wheel wheelPostSx,
                 Balance balanceAnt,
                 Balance balancePost,
                 Spring springAnt,
                 Spring springPost,
                 Damper damperAnt,
                 Damper damperPost) {
        this.id = id;
        this.ala = ala;
        this.note = note;
        this.wheelAntDx = wheelAntDx;
        this.wheelAntSx = wheelAntSx;
        this.wheelPostDx = wheelPostDx;
        this.wheelPostSx = wheelPostSx;
        this.balanceAnt = balanceAnt;
        this.balancePost = balancePost;
        this.springAnt = springAnt;
        this.springPost = springPost;
        this.damperAnt = damperAnt;
        this.damperPost = damperPost;
    }

    public Setup() {

    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getAla() {
        return ala;
    }

    public void setAla(String ala) {
        this.ala = ala;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Wheel getWheelAntDx() {
        return wheelAntDx;
    }

    public void setWheelAntDx(Wheel wheelAntDx) {
        this.wheelAntDx = wheelAntDx;
    }

    public Wheel getWheelAntSx() {
        return wheelAntSx;
    }

    public void setWheelAntSx(Wheel wheelAntSx) {
        this.wheelAntSx = wheelAntSx;
    }

    public Wheel getWheelPostDx() {
        return wheelPostDx;
    }

    public void setWheelPostDx(Wheel wheelPostDx) {
        this.wheelPostDx = wheelPostDx;
    }

    public Wheel getWheelPostSx() {
        return wheelPostSx;
    }

    public void setWheelPostSx(Wheel wheelPostSx) {
        this.wheelPostSx = wheelPostSx;
    }

    public Balance getBalanceAnt() {
        return balanceAnt;
    }

    public void setBalanceAnt(Balance balanceAnt) {
        this.balanceAnt = balanceAnt;
    }

    public Balance getBalancePost() {
        return balancePost;
    }

    public void setBalancePost(Balance balancePost) {
        this.balancePost = balancePost;
    }

    public Spring getSpringAnt() {
        return springAnt;
    }

    public void setSpringAnt(Spring springAnt) {
        this.springAnt = springAnt;
    }

    public Spring getSpringPost() {
        return springPost;
    }

    public void setSpringPost(Spring springPost) {
        this.springPost = springPost;
    }

    public Damper getDamperAnt() {
        return damperAnt;
    }

    public void setDamperAnt(Damper damperAnt) {
        this.damperAnt = damperAnt;
    }

    public Damper getDamperPost() {
        return damperPost;
    }

    public void setDamperPost(Damper damperPost) {
        this.damperPost = damperPost;
    }

    public void setAll(NewSetup request){
        this.ala = request.ala();
        this.note = request.note();
        this.wheelAntDx = request.wheelAntDx();
        this.wheelAntSx = request.wheelAntSx();
        this.wheelPostDx = request.wheelPostDx();
        this.wheelPostSx = request.wheelPostSx();
        this.balanceAnt = request.balanceAnt();
        this.balancePost = request.balancePost();
        this.springAnt = request.springAnt();
        this.springPost = request.springPost();
        this.damperAnt = request.damperAnt();
        this.damperPost = request.damperPost();
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Setup setup = (Setup) o;
        return Objects.equals(id, setup.id) && Objects.equals(ala, setup.ala) && Objects.equals(note, setup.note) && Objects.equals(wheelAntDx, setup.wheelAntDx) && Objects.equals(wheelAntSx, setup.wheelAntSx) && Objects.equals(wheelPostDx, setup.wheelPostDx) && Objects.equals(wheelPostSx, setup.wheelPostSx) && Objects.equals(balanceAnt, setup.balanceAnt) && Objects.equals(balancePost, setup.balancePost) && Objects.equals(springAnt, setup.springAnt) && Objects.equals(springPost, setup.springPost) && Objects.equals(damperAnt, setup.damperAnt) && Objects.equals(damperPost, setup.damperPost);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, ala, note, wheelAntDx, wheelAntSx, wheelPostDx, wheelPostSx, balanceAnt, balancePost, springAnt, springPost, damperAnt, damperPost);
    }

    @Override
    public String toString() {
        return "Setup{" +
                "id=" + id +
                ", ala='" + ala + '\'' +
                ", note='" + note + '\'' +
                ", wheelAntDx=" + wheelAntDx +
                ", wheelAntSx=" + wheelAntSx +
                ", wheelPostDx=" + wheelPostDx +
                ", wheelPostSx=" + wheelPostSx +
                ", balanceAnt=" + balanceAnt +
                ", balancePost=" + balancePost +
                ", springAnt=" + springAnt +
                ", springPost=" + springPost +
                ", damperAnt=" + damperAnt +
                ", damperPost=" + damperPost +
                '}';
    }
}
