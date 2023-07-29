package com.example.polimarche_api.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import java.util.Objects;

@Entity
@Table(name="officina")
public class Workshop {

    @Id
    @Column(name = "reparto", nullable = false, length = 50)
    private String reparto;

    public Workshop() {
    }

    public Workshop(String reparto) {
        this.reparto = reparto;
    }

    public String getReparto() {
        return reparto;
    }

    public void setReparto(String reparto) {
        this.reparto = reparto;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Workshop workshop = (Workshop) o;
        return Objects.equals(reparto, workshop.reparto);
    }

    @Override
    public int hashCode() {
        return Objects.hash(reparto);
    }

    @Override
    public String toString() {
        return "Workshop{" +
                "reparto='" + reparto + '\'' +
                '}';
    }
}
