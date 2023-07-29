package com.example.polimarche_api.model;

import jakarta.persistence.*;
import org.antlr.v4.runtime.misc.NotNull;
import org.springframework.boot.context.properties.bind.DefaultValue;

import java.util.Objects;


@Entity
@Table(name = "tracciato")
public class Track {

    @Id
    @Column(name = "nome", nullable = false, length = 50)
    private String nome;

    @Column(name = "lunghezza", nullable = false)
    private Double lunghezza;

    public Track() {
    }

    public Track(String nome, Double lunghezza) {
        this.nome = nome;
        this.lunghezza = lunghezza;
    }


    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public Double getLunghezza() {
        return lunghezza;
    }

    public void setLunghezza(Double lunghezza) {
        this.lunghezza = lunghezza;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Track track = (Track) o;
        return Objects.equals(nome, track.nome) && Objects.equals(lunghezza, track.lunghezza);
    }

    @Override
    public int hashCode() {
        return Objects.hash(nome, lunghezza);
    }

    @Override
    public String toString() {
        return "Track{" +
                "nome='" + nome + '\'' +
                ", lunghezza=" + lunghezza +
                '}';
    }
}