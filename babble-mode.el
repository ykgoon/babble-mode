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

(defvar seconds-left 12)
(defvar timer-id nil)

(defun babble-mode-run ()
  "Display timer."
  ;; (setq global-mode-string
  ;;      (append global-mode-string 'seconds-left))
  (if (bound-and-true-p babble-mode)
      (setq timer-id
            (run-with-idle-timer seconds-left 1 'erase-buffer))
    (cancel-timer timer-id))

(define-minor-mode babble-mode
  "The thing you do before pruning."
  :init-value nil
  :global nil
  :lighter " Babble"
  :after-hook (babble-mode-run))

(provide 'babble-mode)

;;; babble-mode.el ends here
