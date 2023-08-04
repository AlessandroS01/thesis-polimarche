package com.example.polimarche_api.model;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "problema_incontrato")
public class ProblemEncountered {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @ManyToOne
    @JoinColumn(name = "setup")
    private Setup setup;
    @ManyToOne
    @JoinColumn(name = "problema")
    private Problem problema;
    private String descrizione;

    public ProblemEncountered(Integer id, Setup setup, Problem problema, String descrizione) {
        this.id = id;
        this.setup = setup;
        this.problema = problema;
        this.descrizione = descrizione;
    }

    public ProblemEncountered() {

    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Setup getSetup() {
        return setup;
    }

    public void setSetup(Setup setup) {
        this.setup = setup;
    }

    public Problem getProblema() {
        return problema;
    }

    public void setProblema(Problem problema) {
        this.problema = problema;
    }

    public String getDescrizione() {
        return descrizione;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ProblemEncountered that = (ProblemEncountered) o;
        return Objects.equals(id, that.id) && Objects.equals(setup, that.setup) && Objects.equals(problema, that.problema) && Objects.equals(descrizione, that.descrizione);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, setup, problema, descrizione);
    }

    @Override
    public String toString() {
        return "ProblemEncountered{" +
                "id=" + id +
                ", setup=" + setup +
                ", problema=" + problema +
                ", descrizione='" + descrizione + '\'' +
                '}';
    }
}
