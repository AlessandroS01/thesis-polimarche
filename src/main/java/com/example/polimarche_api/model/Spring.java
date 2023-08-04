package com.example.polimarche_api.model;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "molla")
public class Spring {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String posizione;
    private String codifica;
    @Column(name = "posizione_arb")
    private String posizioneArb;
    @Column(name = "rigidezza_arb")
    private String rigidezzaArb;
    private Double altezza;

    public Spring(Integer id, String posizione, String codifica, String posizioneArb, String rigidezzaArb, Double altezza) {
        this.id = id;
        this.posizione = posizione;
        this.codifica = codifica;
        this.posizioneArb = posizioneArb;
        this.rigidezzaArb = rigidezzaArb;
        this.altezza = altezza;
    }


    public Spring() {

    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPosizione() {
        return posizione;
    }

    public void setPosizione(String posizione) {
        this.posizione = posizione;
    }

    public String getCodifica() {
        return codifica;
    }

    public void setCodifica(String codifica) {
        this.codifica = codifica;
    }

    public String getPosizioneArb() {
        return posizioneArb;
    }

    public void setPosizioneArb(String posizioneArb) {
        this.posizioneArb = posizioneArb;
    }

    public String getRigidezzaArb() {
        return rigidezzaArb;
    }

    public void setRigidezzaArb(String rigidezzaArb) {
        this.rigidezzaArb = rigidezzaArb;
    }

    public Double getAltezza() {
        return altezza;
    }

    public void setAltezza(Double altezza) {
        this.altezza = altezza;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Spring spring = (Spring) o;
        return Objects.equals(id, spring.id) && Objects.equals(posizione, spring.posizione) && Objects.equals(codifica, spring.codifica) && Objects.equals(posizioneArb, spring.posizioneArb) && Objects.equals(rigidezzaArb, spring.rigidezzaArb) && Objects.equals(altezza, spring.altezza);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, posizione, codifica, posizioneArb, rigidezzaArb, altezza);
    }

    @Override
    public String toString() {
        return "Spring{" +
                "id=" + id +
                ", posizione='" + posizione + '\'' +
                ", codifica='" + codifica + '\'' +
                ", posizioneArb='" + posizioneArb + '\'' +
                ", rigidezzaArb='" + rigidezzaArb + '\'' +
                ", altezza=" + altezza +
                '}';
    }
}
