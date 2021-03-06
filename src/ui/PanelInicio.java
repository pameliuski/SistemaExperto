/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ui;

import java.awt.event.ActionListener;

/**
 *
 * @author Nicole
 */
public class PanelInicio extends javax.swing.JPanel {

    /**
     * Creates new form PanelInicio
     */
    public PanelInicio() {
        initComponents();
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        labelTitulo = new javax.swing.JLabel();
        labelDescripcionGeneral = new javax.swing.JLabel();
        botonEmpezar = new javax.swing.JButton();
        labelFotoInicio = new javax.swing.JLabel();

        setBackground(new java.awt.Color(102, 102, 102));
        setMinimumSize(new java.awt.Dimension(800, 600));
        setPreferredSize(new java.awt.Dimension(800, 600));

        labelTitulo.setBackground(new java.awt.Color(204, 204, 204));
        labelTitulo.setFont(new java.awt.Font("Tahoma", 1, 24)); // NOI18N
        labelTitulo.setForeground(new java.awt.Color(255, 255, 255));
        labelTitulo.setText("Bienvenido al Sistema Experto de Planificacion Aerea Militar");

        labelDescripcionGeneral.setForeground(new java.awt.Color(204, 204, 204));
        labelDescripcionGeneral.setText("<html>El objetivo de este Sistema Experto es encontrar un plan de transporte aereo militar dado una ubicacion inicial ,un destino,tipo de carga que desea llevar, como tambien la cantidad de esta.Al introducir estos datos nos dara como resultado los posibles pasos a seguir del plan encontrado.  </html>");

        botonEmpezar.setText("Empezar");
        botonEmpezar.setName("botonEmpezar"); // NOI18N
        botonEmpezar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                botonEmpezarActionPerformed(evt);
            }
        });

        labelFotoInicio.setIcon(new javax.swing.ImageIcon(getClass().getResource("/ui/bienvenida.jpg"))); // NOI18N

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(botonEmpezar, javax.swing.GroupLayout.PREFERRED_SIZE, 83, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(labelFotoInicio, javax.swing.GroupLayout.PREFERRED_SIZE, 562, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(labelDescripcionGeneral, javax.swing.GroupLayout.PREFERRED_SIZE, 560, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(117, 117, 117))
            .addGroup(layout.createSequentialGroup()
                .addGap(33, 33, 33)
                .addComponent(labelTitulo)
                .addContainerGap(51, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addGap(68, 68, 68)
                .addComponent(labelTitulo)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(labelDescripcionGeneral, javax.swing.GroupLayout.DEFAULT_SIZE, 69, Short.MAX_VALUE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(labelFotoInicio, javax.swing.GroupLayout.PREFERRED_SIZE, 267, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(51, 51, 51)
                .addComponent(botonEmpezar)
                .addGap(71, 71, 71))
        );
    }// </editor-fold>//GEN-END:initComponents

    private void botonEmpezarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_botonEmpezarActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_botonEmpezarActionPerformed


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton botonEmpezar;
    private javax.swing.JLabel labelDescripcionGeneral;
    private javax.swing.JLabel labelFotoInicio;
    private javax.swing.JLabel labelTitulo;
    // End of variables declaration//GEN-END:variables

    void addOnClickEmpezarEventListener(ActionListener actionListener) {
        this.botonEmpezar.addActionListener(actionListener);
    }
}
