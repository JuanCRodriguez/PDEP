(ns drcasa.core-test
  (:require [clojure.test :refer :all]
            [drcasa.core :refer :all]))

(deftest test-001
  (testing "La malaria de 800 celulas se reproduce"
    (is (= 1600 ((comp :celulasAmenazadas reproducirse) otraMalaria)))))

(deftest test-002
  (testing "Frank contrae la malaria de 800 celulas")
  (let [_frank (contraerEnfermedad frank otraMalaria) _malaria ((comp first :enfermedades) _frank)]
    (is (identical? otraMalaria _malaria)
    (is (= 800 (:celulasAmenazadas _malaria))))))

(deftest test-003
  (testing "Logan vive un dia en su vida")
  (let [_logan (pasarDia logan) _enfermedades (:enfermedades _logan)]
    (is (= 48 (:temperatura _logan)))
    (is (= 2990000 (:celulas _logan)))
    (is (every? (comp (partial = 1) :cantDias) (getEnfAutoInmunes _logan)))
    (is (enComa? _logan))))

(deftest test-004
  (testing "Frank contrae lupus y pasan 5 dias")
  (let [_frank (pasarDias(contraerEnfermedad frank lupus) 5)]
    (is (= 3450000 (:celulas _frank)))
    (is (= 5 ((comp :cantDias first :enfermedades) _frank)))
    (is (enComa? _frank))))

(deftest test-005
  (testing "un medico tiene una dosis de medicamento de 30")
    (is (= 30 (calcularAtenuacion unMedico)))
  )

(deftest test-006
  (testing "frank contrae malaria y unMedico se la atenua")
  (let [_frank ((comp (partial curar unMedico) contraerEnfermedad) frank unaMalaria)]
    (is (= 470 ((comp :celulasAmenazadas first :enfermedades) _frank)))))

(deftest test-007
  (testing "otroMedico cura todas las enfermedades de logan menos la lupus")
  (let [_logan (curar otroMedico logan) _lupus ((comp first :enfermedades) _logan)]
    (is (= "Lupus" (:nombre _lupus)))
    (is (= 9400 (:celulasAmenazadas _lupus))))
  )

(deftest test-008
  (testing "House envia un subordinado a atenuar la otitis de frank")
  (let [_frank (curar house (contraerEnfermedad frank otitis))]
    (is (= 70 ((comp :celulasAmenazadas first :enfermedades) _frank))))
  )

(deftest test-009)
  (testing "un medico contrae Malaria y se la atenua a si mismo")
  (let [_unMedico (curarse (contraerEnfermedad unMedico otraMalaria))]
    (is (= 770 ((comp :celulasAmenazadas first :enfermedades) _unMedico))))

(run-tests 'drcasa.core-test)