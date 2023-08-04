package com.example.polimarche_api.model;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "utilizzo")
public class UsedSetup {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @ManyToOne
    @JoinColumn(name = "sessione")
    private PracticeSession sessione;
    @ManyToOne
    @JoinColumn(name = "setup")
    private Setup setup;
    private String commento;

    public UsedSetup(Integer id, PracticeSession sessione, Setup setup, String commento) {
        this.id = id;
        this.sessione = sessione;
        this.setup = setup;
        this.commento = commento;
    }

    public UsedSetup() {

    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public PracticeSession getSessione() {
        return sessione;
    }

    public void setSessione(PracticeSession sessione) {
        this.sessione = sessione;
    }

    public Setup getSetup() {
        return setup;
    }

    public void setSetup(Setup setup) {
        this.setup = setup;
    }

    public String getCommento() {
        return commento;
    }

    public void setCommento(String commento) {
        this.commento = commento;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        UsedSetup usedSetup = (UsedSetup) o;
        return Objects.equals(id, usedSetup.id) && Objects.equals(sessione, usedSetup.sessione) && Objects.equals(setup, usedSetup.setup) && Objects.equals(commento, usedSetup.commento);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, sessione, setup, commento);
    }

    @Override
    public String toString() {
        return "UsedSetup{" +
                "id=" + id +
                ", sessione=" + sessione +
                ", setup=" + setup +
                ", commento='" + commento + '\'' +
                '}';
    }
}
