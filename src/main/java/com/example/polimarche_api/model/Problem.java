package com.example.polimarche_api.model;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name="problema")
public class Problem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String descrizione;



    public Problem() {

    }

    public Problem(Integer id, String descrizione) {
        this.id = id;
        this.descrizione = descrizione;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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
        Problem problem = (Problem) o;
        return Objects.equals(id, problem.id) && Objects.equals(descrizione, problem.descrizione);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, descrizione);
    }

    @Override
    public String toString() {
        return "Problem{" +
                "id=" + id +
                ", descrizione='" + descrizione + '\'' +
                '}';
    }
}
