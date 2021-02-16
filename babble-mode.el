;;; babble-mode.el ---

;; Copyright (C) 2021 YK Goon

;; Author: YK Goon <ykgoon@gmail.com>
;; Version: 0.1

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; babble-mode

;;; Code:

(defvar seconds-left 16)
(defvar timer-id nil)
(defvar babble-buffer-name nil)

(spaceline-define-segment babble-segment
  "Babble timer"
  (when (bound-and-true-p babble-mode)
    (progn
      (setq idle-time (current-idle-time))
      (if idle-time
        (concat (number-to-string
                 (- seconds-left
                    (first (decode-time idle-time))))
                "s")
        (concat (number-to-string seconds-left) "s"))))
  :when active)
(add-to-list 'spacemacs-spaceline-additional-segments
             '(babble-segment))
(spaceline-spacemacs-theme '(babble-segment))

(defun babble-mode-punish ()
  (set-buffer babble-buffer-name)
  (erase-buffer))

(defun babble-mode-run ()
  (if (bound-and-true-p babble-mode)
      (progn
        (setq babble-buffer-name (current-buffer))
        (setq timer-id
              (run-with-idle-timer seconds-left 1 'babble-mode-punish)))
    (cancel-timer timer-id)))

(define-minor-mode babble-mode
  "The thing you do before pruning."
  :init-value nil
  :global nil
  :lighter " Babble "
  :after-hook (babble-mode-run))

(provide 'babble-mode)

;;; babble-mode.el ends here
