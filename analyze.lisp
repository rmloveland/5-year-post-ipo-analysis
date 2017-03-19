;;; analysis.lisp

(require :cl-csv)
(require :cl-fad)



;; Internal

(defun parse-prices (file)
  ;; Pathname -> Alist (IO!)
  (cl-csv:read-csv file))

(defun get-start-price (prices)
  ;; Alist -> Num
  (let* ((row (first (last prices)))
         (val (nth 4 row))
         (price (read-from-string val)))
    price))

(defun get-end-price (prices)
  ;; Alist -> Num
  (let* ((row (second prices))
         (val (nth 4 row))
         (price (read-from-string val)))
    price))

(defun calculate-growth-ratio (prices)
  ;; List -> Num
  (let ((start (get-start-price prices))
        (end (get-end-price prices)))
    (/ end start)))



;; User-facing

(defun list-csv-files ()
  ;; -> List (IO!)
  (let ((dir (if (string-equal (software-type) "WINDOWS 10")
                 #P"c:/Users/rml/Dropbox/Code/personal/5-year-post-ipo-analysis/csv/"
                 #P"~/Dropbox/Code/personal/5-year-post-ipo-analysis/csv/")))
  (remove-if-not #'(lambda (s)
                     (string-equal "csv" (pathname-type s)))
                 (cl-fad:list-directory dir))))

(defun build-analysis ()
  ;; -> List
  (let* ((csv-files (list-csv-files))
         (vals (mapcar #'(lambda (file)
                          (let* ((prices (parse-prices file))
                                 (ratio (calculate-growth-ratio prices))
                                 (name (pathname-name file)))
                            (list name ratio)))
                      csv-files)))
    (sort vals #'> :key #'second)))

(defun print-analysis ()
  ;; -> IO!
  (let ((results (build-analysis)))
    (loop for elem in results do
         (let ((name (first elem))
               (ratio (second elem)))
           (format t "~A~%~A~%" name ratio)))))
