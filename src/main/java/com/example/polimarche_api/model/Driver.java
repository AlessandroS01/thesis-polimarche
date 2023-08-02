package com.example.polimarche_api.model;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "pilota")
public class Driver {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private Double peso;
    private Integer altezza;

    @OneToOne
    @JoinColumn(name = "membro")
    private Member membro;


    public Driver() {

    }


    public Driver(Integer id, Double peso, Integer altezza, Member membro) {
        this.id = id;
        this.peso = peso;
        this.altezza = altezza;
        this.membro = membro;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Double getPeso() {
        return peso;
    }

    public void setPeso(Double peso) {
        this.peso = peso;
    }

    public Integer getAltezza() {
        return altezza;
    }

    public void setAltezza(Integer altezza) {
        this.altezza = altezza;
    }

    public Member getMembro() {
        return membro;
    }

    public void setMembro(Member membro) {
        this.membro = membro;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Driver driver = (Driver) o;
        return Objects.equals(id, driver.id) && Objects.equals(peso, driver.peso) && Objects.equals(altezza, driver.altezza) && Objects.equals(membro, driver.membro);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, peso, altezza, membro);
    }

    @Override
    public String toString() {
        return "Driver{" +
                "id=" + id +
                ", peso=" + peso +
                ", altezza=" + altezza +
                ", membro=" + membro +
                '}';
    }
}
