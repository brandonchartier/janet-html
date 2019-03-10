(def eq-nil?
  (partial = nil))

(defn all-nil?
  [& args]
  (all eq-nil? args))

(defn none-nil?
  [& args]
  (all (complement eq-nil?) args))

(defn first-nil?
  [a & args]
  (and (nil? a)
       (none-nil? args)))
