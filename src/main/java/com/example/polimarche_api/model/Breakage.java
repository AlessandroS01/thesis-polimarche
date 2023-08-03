package com.example.polimarche_api.model;

import jakarta.persistence.*;

import java.sql.Time;
import java.util.Date;
import java.util.Objects;

@Entity
@Table(name="rottura")
public class Breakage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String descrizione;



    public Breakage() {

    }

    public Breakage(Integer id, String descrizione, Boolean driver) {
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
        Breakage breakage = (Breakage) o;
        return Objects.equals(id, breakage.id) && Objects.equals(descrizione, breakage.descrizione);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, descrizione);
    }

    @Override
    public String toString() {
        return "Breakage{" +
                "id=" + id +
                ", descrizione='" + descrizione + '\'' +
                '}';
    }
}
