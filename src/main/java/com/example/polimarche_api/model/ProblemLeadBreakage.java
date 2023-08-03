package com.example.polimarche_api.model;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name= "rottura_causa_problema")
public class ProblemLeadBreakage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @ManyToOne
    @JoinColumn(name = "problema")
    private Problem problema;
    @ManyToOne
    @JoinColumn(name = "rottura")
    private Breakage rottura;
    private String descrizione;

    public ProblemLeadBreakage() {
    }

    public ProblemLeadBreakage(Integer id, Problem problema, Breakage rottura, String descrizione) {
        this.id = id;
        this.problema = problema;
        this.rottura = rottura;
        this.descrizione = descrizione;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Problem getProblema() {
        return problema;
    }

    public void setProblema(Problem problema) {
        this.problema = problema;
    }

    public Breakage getRottura() {
        return rottura;
    }

    public void setRottura(Breakage rottura) {
        this.rottura = rottura;
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
        ProblemLeadBreakage that = (ProblemLeadBreakage) o;
        return Objects.equals(id, that.id) && Objects.equals(problema, that.problema) && Objects.equals(rottura, that.rottura) && Objects.equals(descrizione, that.descrizione);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, problema, rottura, descrizione);
    }

    @Override
    public String toString() {
        return "ProblemLeadBreakage{" +
                "id=" + id +
                ", problema=" + problema +
                ", rottura=" + rottura +
                ", descrizione='" + descrizione + '\'' +
                '}';
    }
}
