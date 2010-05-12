<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head><title>EmacsWiki: anything.el</title><link rel="alternate" type="application/wiki" title="Edit this page" href="http://www.emacswiki.org/emacs?action=edit;id=anything.el" /><link type="text/css" rel="stylesheet" href="/emacs/wiki.css" /><meta name="robots" content="INDEX,FOLLOW" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki" href="http://www.emacswiki.org/emacs?action=rss" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki: anything.el" href="http://www.emacswiki.org/emacs?action=rss;rcidonly=anything.el" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content"
      href="http://www.emacswiki.org/emacs/full.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content and diff"
      href="http://www.emacswiki.org/emacs/full-diff.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki including minor differences"
      href="http://www.emacswiki.org/emacs/minor-edits.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Changes for anything.el only"
      href="http://www.emacswiki.org/emacs?action=rss;rcidonly=anything.el" /><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/></head><body class="http://www.emacswiki.org/emacs"><div class="header"><a class="logo" href="http://www.emacswiki.org/emacs/SiteMap"><img class="logo" src="/emacs_logo.png" alt="[Home]" /></a><span class="gotobar bar"><a class="local" href="http://www.emacswiki.org/emacs/SiteMap">SiteMap</a> <a class="local" href="http://www.emacswiki.org/emacs/Search">Search</a> <a class="local" href="http://www.emacswiki.org/emacs/ElispArea">ElispArea</a> <a class="local" href="http://www.emacswiki.org/emacs/HowTo">HowTo</a> <a class="local" href="http://www.emacswiki.org/emacs/RecentChanges">RecentChanges</a> <a class="local" href="http://www.emacswiki.org/emacs/News">News</a> <a class="local" href="http://www.emacswiki.org/emacs/Problems">Problems</a> <a class="local" href="http://www.emacswiki.org/emacs/Suggestions">Suggestions</a> </span>
<!-- Google CSE Search Box Begins  -->
<form class="tiny" action="http://www.google.com/cse" id="searchbox_004774160799092323420:6-ff2s0o6yi"><p>
<input type="hidden" name="cx" value="004774160799092323420:6-ff2s0o6yi" />
<input type="text" name="q" size="25" />
<input type="submit" name="sa" value="Search" />
</p></form>
<script type="text/javascript" src="http://www.google.com/coop/cse/brand?form=searchbox_004774160799092323420%3A6-ff2s0o6yi"></script>
<!-- Google CSE Search Box Ends -->
<br /><span class="specialdays">Andorra, National Day, Former Yugoslav Republic of Macedonia, Independence Day</span><h1><a title="Click to search for references to this page" rel="nofollow" href="http://www.google.com/cse?cx=004774160799092323420:6-ff2s0o6yi&amp;q=%22anything.el%22">anything.el</a></h1></div><div class="wrapper"><div class="content browse"><p><a href="http://www.emacswiki.org/emacs/download/anything.el">Download</a></p><pre class="code"><span class="linecomment">;;;; anything.el --- open anything / QuickSilver-like candidate-selection framework</span>
<span class="linecomment">;; $Id: anything.el,v 1.201 2009/08/08 13:25:30 rubikitch Exp rubikitch $</span>

<span class="linecomment">;; Copyright (C) 2007        Tamas Patrovics</span>
<span class="linecomment">;;               2008, 2009  rubikitch &lt;rubikitch@ruby-lang.org&gt;</span>

<span class="linecomment">;; Author: Tamas Patrovics</span>
<span class="linecomment">;; Maintainer: rubikitch &lt;rubikitch@ruby-lang.org&gt;</span>
<span class="linecomment">;; Keywords: files, frames, help, matching, outlines, processes, tools, convenience, anything</span>
<span class="linecomment">;; URL: http://www.emacswiki.org/cgi-bin/wiki/download/anything.el</span>
<span class="linecomment">;; Site: http://www.emacswiki.org/cgi-bin/emacs/Anything</span>

<span class="linecomment">;; This file is free software; you can redistribute it and/or modify</span>
<span class="linecomment">;; it under the terms of the GNU General Public License as published by</span>
<span class="linecomment">;; the Free Software Foundation; either version 2, or (at your option)</span>
<span class="linecomment">;; any later version.</span>

<span class="linecomment">;; This file is distributed in the hope that it will be useful,</span>
<span class="linecomment">;; but WITHOUT ANY WARRANTY; without even the implied warranty of</span>
<span class="linecomment">;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span>

<span class="linecomment">;; GNU General Public License for more details.</span>

<span class="linecomment">;; You should have received a copy of the GNU General Public License</span>
<span class="linecomment">;; along with GNU Emacs; see the file COPYING.  If not, write to the</span>
<span class="linecomment">;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,</span>
<span class="linecomment">;; Boston, MA 02110-1301, USA.</span>

<span class="linecomment">;;; Commentary:</span>

<span class="linecomment">;;</span>
<span class="linecomment">;; Start with M-x anything, narrow the list by typing some pattern,</span>
<span class="linecomment">;; select with up/down/pgup/pgdown/C-p/C-n/C-v/M-v, choose with enter,</span>
<span class="linecomment">;; left/right moves between sources. With TAB actions can be selected</span>
<span class="linecomment">;; if the selected candidate has more than one possible action.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Note that anything.el provides only the framework and some example</span>
<span class="linecomment">;; configurations for demonstration purposes. See anything-config.el</span>
<span class="linecomment">;; for practical, polished, easy to use configurations which can be</span>
<span class="linecomment">;; used to assemble a custom personalized configuration. And many</span>
<span class="linecomment">;; other configurations are in the EmacsWiki.</span>
<span class="linecomment">;; </span>
<span class="linecomment">;; http://www.emacswiki.org/cgi-bin/wiki/download/anything-config.el</span>
<span class="linecomment">;; http://www.emacswiki.org/cgi-bin/emacs/AnythingSources</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Maintainer's configuration is in the EmacsWiki. It would tell you</span>
<span class="linecomment">;; many tips to write smart sources!</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; http://www.emacswiki.org/cgi-bin/emacs/RubikitchAnythingConfiguration</span>

<span class="linecomment">;;; Commands:</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Below are complete command list:</span>
<span class="linecomment">;;</span>
<span class="linecomment">;;  `anything'</span>
<span class="linecomment">;;    Select anything. In Lisp program, some optional arguments can be used.</span>
<span class="linecomment">;;  `anything-resume'</span>
<span class="linecomment">;;    Resurrect previously invoked `anything'.</span>
<span class="linecomment">;;  `anything-at-point'</span>
<span class="linecomment">;;    Same as `anything' except when C-u is pressed, the initial input is the symbol at point.</span>
<span class="linecomment">;;  `anything-select-action'</span>
<span class="linecomment">;;    Select an action for the currently selected candidate.</span>
<span class="linecomment">;;  `anything-previous-line'</span>
<span class="linecomment">;;    Move selection to the previous line.</span>
<span class="linecomment">;;  `anything-next-line'</span>
<span class="linecomment">;;    Move selection to the next line.</span>
<span class="linecomment">;;  `anything-previous-page'</span>
<span class="linecomment">;;    Move selection back with a pageful.</span>
<span class="linecomment">;;  `anything-next-page'</span>
<span class="linecomment">;;    Move selection forward with a pageful.</span>
<span class="linecomment">;;  `anything-previous-source'</span>
<span class="linecomment">;;    Move selection to the previous source.</span>
<span class="linecomment">;;  `anything-next-source'</span>
<span class="linecomment">;;    Move selection to the next source.</span>
<span class="linecomment">;;  `anything-exit-minibuffer'</span>
<span class="linecomment">;;    Select the current candidate by exiting the minibuffer.</span>
<span class="linecomment">;;  `anything-delete-current-selection'</span>
<span class="linecomment">;;    Delete the currently selected item.</span>
<span class="linecomment">;;  `anything-delete-minibuffer-content'</span>
<span class="linecomment">;;    Same as `delete-minibuffer-contents' but this is a command.</span>
<span class="linecomment">;;  `anything-select-2nd-action'</span>
<span class="linecomment">;;    Select the 2nd action for the currently selected candidate.</span>
<span class="linecomment">;;  `anything-select-3rd-action'</span>
<span class="linecomment">;;    Select the 3rd action for the currently selected candidate.</span>
<span class="linecomment">;;  `anything-select-4th-action'</span>
<span class="linecomment">;;    Select the 4th action for the currently selected candidate.</span>
<span class="linecomment">;;  `anything-select-2nd-action-or-end-of-line'</span>
<span class="linecomment">;;    Select the 2nd action for the currently selected candidate if the point is at the end of minibuffer.</span>
<span class="linecomment">;;  `anything-execute-persistent-action'</span>
<span class="linecomment">;;    If a candidate is selected then perform the associated action without quitting anything.</span>
<span class="linecomment">;;  `anything-scroll-other-window'</span>
<span class="linecomment">;;    Scroll other window (not *Anything* window) upward.</span>
<span class="linecomment">;;  `anything-scroll-other-window-down'</span>
<span class="linecomment">;;    Scroll other window (not *Anything* window) downward.</span>
<span class="linecomment">;;  `anything-quit-and-find-file'</span>
<span class="linecomment">;;    Drop into `find-file' from `anything' like `iswitchb-find-file'.</span>
<span class="linecomment">;;  `anything-yank-selection'</span>
<span class="linecomment">;;    Set minibuffer contents to current selection.</span>
<span class="linecomment">;;  `anything-kill-selection-and-quit'</span>
<span class="linecomment">;;    Store current selection to kill ring.</span>
<span class="linecomment">;;  `anything-follow-mode'</span>
<span class="linecomment">;;    If this mode is on, persistent action is executed everytime the cursor is moved.</span>
<span class="linecomment">;;  `anything-isearch'</span>
<span class="linecomment">;;    Start incremental search within results. (UNMAINTAINED)</span>
<span class="linecomment">;;  `anything-isearch-printing-char'</span>
<span class="linecomment">;;    Add printing char to the pattern.</span>
<span class="linecomment">;;  `anything-isearch-again'</span>
<span class="linecomment">;;    Search again for the current pattern</span>
<span class="linecomment">;;  `anything-isearch-delete'</span>
<span class="linecomment">;;    Undo last event.</span>
<span class="linecomment">;;  `anything-isearch-default-action'</span>
<span class="linecomment">;;    Execute the default action for the selected candidate.</span>
<span class="linecomment">;;  `anything-isearch-select-action'</span>
<span class="linecomment">;;    Choose an action for the selected candidate.</span>
<span class="linecomment">;;  `anything-isearch-cancel'</span>
<span class="linecomment">;;    Cancel Anything isearch.</span>
<span class="linecomment">;;  `anything-iswitchb-setup'</span>
<span class="linecomment">;;    Integrate anything completion into iswitchb (UNMAINTAINED).</span>
<span class="linecomment">;;  `anything-iswitchb-cancel-anything'</span>
<span class="linecomment">;;    Cancel anything completion and return to standard iswitchb.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;;; Customizable Options:</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Below are customizable option list:</span>
<span class="linecomment">;;</span>

<span class="linecomment">;; You can extend `anything' by writing plug-ins. As soon as</span>
<span class="linecomment">;; `anything' is invoked, `anything-sources' is compiled into basic</span>
<span class="linecomment">;; attributes, then compiled one is used during invocation.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; The oldest built-in plug-in is `type' attribute: appends</span>
<span class="linecomment">;; appropriate element of `anything-type-attributes'. Second built-in</span>
<span class="linecomment">;; plug-in is `candidates-in-buffer': selecting a line from candidates</span>
<span class="linecomment">;; buffer.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; To write a plug-in:</span>
<span class="linecomment">;; 1. Define a compiler: anything-compile-source--*</span>
<span class="linecomment">;; 2. Add compier function to `anything-compile-source-functions'.</span>
<span class="linecomment">;; 3. (optional) Write helper functions.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Anything plug-ins are found in the EmacsWiki.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; http://www.emacswiki.org/cgi-bin/emacs/AnythingPlugins</span>

<span class="linecomment">;; Tested on Emacs 22.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Thanks to Vagn Johansen for ideas.</span>
<span class="linecomment">;; Thanks to Stefan Kamphausen for fixes and XEmacs support.</span>
<span class="linecomment">;; Thanks to Tassilo Horn for fixes.</span>
<span class="linecomment">;; Thanks to Drew Adams for various fixes (frame, isearch, customization, etc.)</span>
<span class="linecomment">;; Thanks to IMAKADO for candidates-in-buffer idea.</span>
<span class="linecomment">;; Thanks to Tomohiro MATSUYAMA for multiline patch.</span>
<span class="linecomment">;;</span>

<span class="linecomment">;;; (@* "Index")</span>

<span class="linecomment">;;  If you have library `linkd.el', load</span>
<span class="linecomment">;;  `linkd.el' and turn on `linkd-mode' now.  It lets you easily</span>
<span class="linecomment">;;  navigate around the sections  Linkd mode will</span>
<span class="linecomment">;;  highlight this Index.  You can get `linkd.el' here:</span>
<span class="linecomment">;;  http://www.emacswiki.org/cgi-bin/wiki/download/linkd.el</span>
<span class="linecomment">;;</span>


<span class="linecomment">;;; (@* "INCOMPATIBLE CHANGES")</span>

<span class="linecomment">;; v1.114</span>
<span class="linecomment">;;</span>
<span class="linecomment">;;   `anything-attr' returns nil when the source attribute is defined</span>
<span class="linecomment">;;   but the value of attribute is nil, eg. (volatile) cell. Use</span>
<span class="linecomment">;;   `anything-attr-defined' when testing whether the attribute is</span>
<span class="linecomment">;;   defined.</span>

<span class="linecomment">;;; (@* "Tips")</span>

<span class="linecomment">;;</span>
<span class="linecomment">;; Now symbols are acceptable as candidates. So you do not have to use</span>
<span class="linecomment">;; `symbol-name' function. The source is much simpler. For example,</span>
<span class="linecomment">;; `apropos-internal' returns a list of symbols.</span>
<span class="linecomment">;; </span>
<span class="linecomment">;;   (anything</span>
<span class="linecomment">;;    '(((name . "Commands")</span>
<span class="linecomment">;;       (candidates . (lambda () (apropos-internal anything-pattern 'commandp)))</span>
<span class="linecomment">;;       (volatile)</span>
<span class="linecomment">;;       (action . describe-function))))</span>

<span class="linecomment">;;</span>
<span class="linecomment">;; To mark a candidate, press C-SPC as normal Emacs marking. To go to</span>
<span class="linecomment">;; marked candidate, press M-[ or M-].</span>

<span class="linecomment">;;</span>
<span class="linecomment">;; `anything-map' is now Emacs-standard key bindings by default. If</span>
<span class="linecomment">;; you are using `iswitchb', execute `anything-iswitchb-setup'. Then</span>
<span class="linecomment">;; some key bindings are adjusted to `iswitchb'. Note that</span>
<span class="linecomment">;; anything-iswitchb is not maintained.</span>

<span class="linecomment">;;</span>
<span class="linecomment">;; There are many `anything' applications, using `anything' for</span>
<span class="linecomment">;; selecting candidate. In this case, if there is one candidate or no</span>
<span class="linecomment">;; candidate, popping up *anything* buffer is irritating. If one</span>
<span class="linecomment">;; candidate, you want to select it at once. If no candidate, you want</span>
<span class="linecomment">;; to quit `anything'. Set `anything-execute-action-at-once-if-one'</span>
<span class="linecomment">;; and `anything-quit-if-no-candidate' to non-nil to remedy it. Note</span>
<span class="linecomment">;; that setting these variables GLOBALLY is bad idea because of</span>
<span class="linecomment">;; delayed sources. These are meant to be let-binded.</span>
<span class="linecomment">;; See anything-etags.el for example.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; [EVAL IT] (install-elisp "http://www.emacswiki.org/cgi-bin/wiki/download/anything-etags.el")</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; ex.</span>
<span class="linecomment">;; (let ((anything-execute-action-at-once-if-one t)</span>
<span class="linecomment">;;       (anything-quit-if-no-candidate (lambda () (message "No candidate"))))</span>
<span class="linecomment">;;    (anything temporary-sources input))</span>

<span class="linecomment">;;</span>
<span class="linecomment">;; `set-frame-configuration' arises flickering. If you hate</span>
<span class="linecomment">;; flickering, eval:</span>
<span class="linecomment">;; (setq anything-save-configuration-functions</span>
<span class="linecomment">;;    '(set-window-configuration . current-window-configuration))</span>
<span class="linecomment">;; at the cost of restoring frame configuration (only window configuration).</span>

<span class="linecomment">;;</span>
<span class="linecomment">;; `anything-delete-current-selection' deletes the current line.</span>
<span class="linecomment">;; It is useful when deleting a candidate in persistent action.</span>
<span class="linecomment">;; eg. `kill-buffer'.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; [EVAL IT] (describe-function 'anything-delete-current-selection)</span>

<span class="linecomment">;;</span>
<span class="linecomment">;; `anything-attr' gets the attribute. `anything-attrset' sets the</span>
<span class="linecomment">;; attribute. `anything-attr-defined' tests whether the attribute is</span>
<span class="linecomment">;; defined. They handles source-local variables.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; [EVAL IT] (describe-function 'anything-attr)</span>
<span class="linecomment">;; [EVAL IT] (describe-function 'anything-attrset)</span>
<span class="linecomment">;; [EVAL IT] (describe-function 'anything-attr-defined)</span>

<span class="linecomment">;;</span>
<span class="linecomment">;; `anything-sources' accepts many attributes to make your life easier.</span>
<span class="linecomment">;; Now `anything-sources' accepts a list of symbols.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; [EVAL IT] (describe-variable 'anything-sources)</span>

<span class="linecomment">;;</span>
<span class="linecomment">;; `anything' has optional arguments. Now you do not have to let-bind</span>
<span class="linecomment">;; `anything-sources'.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; [EVAL IT] (describe-function 'anything)</span>

<span class="linecomment">;;</span>
<span class="linecomment">;; `anything-resume' resumes last `anything' session. Now you do not</span>
<span class="linecomment">;; have to retype pattern.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; [EVAL IT] (describe-function 'anything-resume)</span>

<span class="linecomment">;;</span>
<span class="linecomment">;; `anything-execute-persistent-action' executes action without</span>
<span class="linecomment">;; quitting `anything'. When popping up a buffer in other window by</span>
<span class="linecomment">;; persistent action, you can scroll with `anything-scroll-other-window' and</span>
<span class="linecomment">;; `anything-scroll-other-window-down'. See also `anything-sources' docstring.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; [EVAL IT] (describe-function 'anything-execute-persistent-action)</span>
<span class="linecomment">;; [EVAL IT] (describe-variable 'anything-sources)</span>

<span class="linecomment">;;</span>
<span class="linecomment">;; `anything-select-2nd-action', `anything-select-3rd-action' and</span>
<span class="linecomment">;; `anything-select-4th-action' select other than default action</span>
<span class="linecomment">;; without pressing Tab.</span>

<span class="linecomment">;;</span>
<span class="linecomment">;; Using `anything-candidate-buffer' and the candidates-in-buffer</span>
<span class="linecomment">;; attribute is much faster than traditional "candidates and match"</span>
<span class="linecomment">;; way. And `anything-current-buffer-is-modified' avoids to</span>
<span class="linecomment">;; recalculate candidates for unmodified buffer. See docstring of</span>
<span class="linecomment">;; them.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; [EVAL IT] (describe-function 'anything-candidate-buffer)</span>
<span class="linecomment">;; [EVAL IT] (describe-function 'anything-candidates-in-buffer)</span>
<span class="linecomment">;; [EVAL IT] (describe-function 'anything-current-buffer-is-modified)</span>

<span class="linecomment">;;</span>
<span class="linecomment">;; `anything-current-buffer' and `anything-buffer-file-name' stores</span>
<span class="linecomment">;; `(current-buffer)' and `buffer-file-name' in the buffer `anything'</span>
<span class="linecomment">;; is invoked. Use them freely.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; [EVAL IT] (describe-variable 'anything-current-buffer)</span>
<span class="linecomment">;; [EVAL IT] (describe-variable 'anything-buffer-file-name)</span>

<span class="linecomment">;;</span>
<span class="linecomment">;; `anything-completing-read' and `anything-read-file-name' are</span>
<span class="linecomment">;; experimental implementation. If you are curious, type M-x</span>
<span class="linecomment">;; anything-read-string-mode. It is a minor mode and toggles on/off.</span>

<span class="linecomment">;;</span>
<span class="linecomment">;; Use `anything-test-candidates' to test your handmade anything</span>
<span class="linecomment">;; sources. It simulates contents of *anything* buffer with pseudo</span>
<span class="linecomment">;; `anything-sources' and `anything-pattern', without side-effect. So</span>
<span class="linecomment">;; you can unit-test your anything sources! Let's TDD!</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; [EVAL IT] (describe-function 'anything-test-candidates)</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; There are many unit-testing framework in Emacs Lisp. See the EmacsWiki.</span>
<span class="linecomment">;; http://www.emacswiki.org/cgi-bin/emacs/UnitTesting</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; There is an unit-test by Emacs Lisp Expectations at the tail of this file.</span>
<span class="linecomment">;; http://www.emacswiki.org/cgi-bin/wiki/download/el-expectations.el</span>
<span class="linecomment">;; http://www.emacswiki.org/cgi-bin/wiki/download/el-mock.el</span>


<span class="linecomment">;; (@* "TODO")</span>
<span class="linecomment">;;</span>
<span class="linecomment">;;   - process status indication</span>
<span class="linecomment">;;</span>
<span class="linecomment">;;   - async sources doesn't honor digit-shortcut-count</span>
<span class="linecomment">;;</span>
<span class="linecomment">;;   - anything-candidate-number-limit can't be nil everywhere</span>

<span class="linecomment">;; (@* "HISTORY")</span>
<span class="linecomment">;; $Log: anything.el,v $</span>
<span class="linecomment">;; Revision 1.201  2009/08/08 13:25:30  rubikitch</span>
<span class="linecomment">;; `anything-toggle-visible-mark': move next line after unmarking</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.200  2009/08/08 13:23:46  rubikitch</span>
<span class="linecomment">;; `anything-toggle-visible-mark': Applied ThierryVolpiatto's patch. thx.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.199  2009/07/19 13:22:29  rubikitch</span>
<span class="linecomment">;; `anything-follow-execute-persistent-action-maybe': execute persistent action after `anything-input-idle-delay'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.198  2009/07/06 15:22:48  rubikitch</span>
<span class="linecomment">;; header modified (no code change)</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.197  2009/06/29 15:10:13  rubikitch</span>
<span class="linecomment">;; OOPS! remove debug code</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.196  2009/06/29 13:29:25  rubikitch</span>
<span class="linecomment">;; anything-follow-mode: automatical execution of persistent-action (C-c C-f)</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.195  2009/06/19 14:42:57  rubikitch</span>
<span class="linecomment">;; silence byte compiler</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.194  2009/06/14 15:12:34  rubikitch</span>
<span class="linecomment">;; typo</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.193  2009/06/08 19:37:12  rubikitch</span>
<span class="linecomment">;; typo!</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.192  2009/06/08 19:36:39  rubikitch</span>
<span class="linecomment">;; New keybind: C-e, C-j, C-k</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.191  2009/06/08 19:30:27  rubikitch</span>
<span class="linecomment">;; New command: `anything-select-2nd-action-or-end-of-line'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.190  2009/06/07 17:09:50  rubikitch</span>
<span class="linecomment">;; add M-&lt;next&gt;, C-M-S-v, M-&lt;prior&gt; to `anything-map'.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.189  2009/06/01 21:36:31  rubikitch</span>
<span class="linecomment">;; New function: `anything-other-buffer'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.188  2009/05/29 18:33:07  rubikitch</span>
<span class="linecomment">;; avoid error when executing (anything-mark-current-line) in async process.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.187  2009/05/29 06:49:05  rubikitch</span>
<span class="linecomment">;; small refactoring</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.186  2009/05/29 06:46:34  rubikitch</span>
<span class="linecomment">;; Prevent `anything-isearch-map' from overwriting `global-map'. With</span>
<span class="linecomment">;; `copy-keymap', the prefix command "M-s" in `global-map' ends up</span>
<span class="linecomment">;; getting clobbered by `anything-isearch-again', preventing `occur'</span>
<span class="linecomment">;; (among other things) from running. This change replaces overwriting a</span>
<span class="linecomment">;; copied map with writing to a sparse map whose parent is `global-map'.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; patched by DanielHackney. thanks!</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.185  2009/05/25 19:07:42  rubikitch</span>
<span class="linecomment">;; `anything': set `case-fold-search' to t</span>
<span class="linecomment">;; Because users can assign commands to capital letter keys.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.184  2009/05/25 19:05:04  rubikitch</span>
<span class="linecomment">;; Added auto-document</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.183  2009/05/15 01:50:46  rubikitch</span>
<span class="linecomment">;; typo</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.182  2009/05/08 18:28:18  rubikitch</span>
<span class="linecomment">;; Bug fix: `anything-attr' is usable in `header-name' function.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.181  2009/05/04 19:05:03  rubikitch</span>
<span class="linecomment">;; * `anything-yank-selection' and `anything-kill-selection-and-quit' handles display string now.</span>
<span class="linecomment">;; * `anything-get-selection': Added optional arguments.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.180  2009/05/03 19:03:34  rubikitch</span>
<span class="linecomment">;; Add `anything-input' to `minibuffer-history' even if `anything' is quit.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.179  2009/04/20 16:35:44  rubikitch</span>
<span class="linecomment">;; New keybindings in anything-map:</span>
<span class="linecomment">;;   C-c C-d: `anything-delete-current-selection'</span>
<span class="linecomment">;;   C-c C-y: `anything-yank-selection'</span>
<span class="linecomment">;;   C-c C-k: `anything-kill-selection-and-quit'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.178  2009/04/20 16:18:58  rubikitch</span>
<span class="linecomment">;; New variable: `anything-display-function'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.177  2009/04/20 02:17:16  rubikitch</span>
<span class="linecomment">;; New commands: `anything-yank-selection', `anything-kill-selection-and-quit'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.176  2009/04/08 14:48:15  rubikitch</span>
<span class="linecomment">;; bug fix in `anything-candidate-buffer'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.175  2009/03/22 19:10:37  rubikitch</span>
<span class="linecomment">;; New Variable: `anything-scroll-amount' (thx. ThierryVolpiatto)</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.174  2009/03/12 19:12:24  rubikitch</span>
<span class="linecomment">;; New API: `define-anything-type-attribute'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.173  2009/03/11 08:10:32  rubikitch</span>
<span class="linecomment">;; Update doc</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.172  2009/03/10 17:11:58  rubikitch</span>
<span class="linecomment">;; `candidate-transformer', `filtered-candidate-transformer',</span>
<span class="linecomment">;; `action-transformer' attributes: accept a list of functions</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.171  2009/03/09 18:49:44  rubikitch</span>
<span class="linecomment">;; New command: `anything-quit-and-find-file'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.170  2009/03/09 18:46:11  rubikitch</span>
<span class="linecomment">;; New API: `anything-run-after-quit'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.169  2009/03/09 10:02:49  rubikitch</span>
<span class="linecomment">;; Set candidate-number-limit attribute for actions.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.168  2009/03/07 21:01:10  rubikitch</span>
<span class="linecomment">;; Bug workaround</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.167  2009/03/06 04:13:42  rubikitch</span>
<span class="linecomment">;; Fix doc</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.166  2009/03/03 10:35:57  rubikitch</span>
<span class="linecomment">;; Set default `anything-input-idle-delay' to 0.1</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.165  2009/03/03 07:14:42  rubikitch</span>
<span class="linecomment">;; Make sure to run `anything-update-hook' after processing delayed sources.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.164  2009/03/02 01:51:40  rubikitch</span>
<span class="linecomment">;; better error handling.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.163  2009/03/01 05:15:00  rubikitch</span>
<span class="linecomment">;; anything-iswitchb and anything-isearch are marked as unmaintained.</span>
<span class="linecomment">;; (document change only)</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.162  2009/02/28 01:24:13  rubikitch</span>
<span class="linecomment">;; Symbols are now acceptable as candidate.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.161  2009/02/27 07:18:46  rubikitch</span>
<span class="linecomment">;; Fix bug of `anything-scroll-other-window' and `anything-scroll-other-window-down'.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.160  2009/02/27 01:05:06  rubikitch</span>
<span class="linecomment">;; * Make sure to restore point after running `anything-update-hook'.</span>
<span class="linecomment">;; * Make `anything-compute-matches' easy to find error.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.159  2009/02/26 23:45:48  rubikitch</span>
<span class="linecomment">;; * Check whether candidate is a string, otherwise ignore.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.158  2009/02/24 06:39:20  rubikitch</span>
<span class="linecomment">;; suppress compile warnings.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.157  2009/02/23 22:51:43  rubikitch</span>
<span class="linecomment">;; New function: `anything-document-attribute'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.156  2009/02/23 21:36:09  rubikitch</span>
<span class="linecomment">;; New Variable: `anything-display-source-at-screen-top'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.155  2009/02/23 21:30:52  rubikitch</span>
<span class="linecomment">;; New command: `anything-at-point'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.154  2009/02/23 08:57:54  rubikitch</span>
<span class="linecomment">;; Visible Mark</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.153  2009/02/23 08:38:57  rubikitch</span>
<span class="linecomment">;; update doc</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.152  2009/02/23 08:32:17  rubikitch</span>
<span class="linecomment">;; More key bindings.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.151  2009/02/23 08:21:24  rubikitch</span>
<span class="linecomment">;; `anything-map' is now Emacs-standard key bindings by default.</span>
<span class="linecomment">;; After evaluating `anything-iswitchb-setup'. some key bindings are adjusted to iswitchb.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.150  2009/02/20 22:58:18  rubikitch</span>
<span class="linecomment">;; Cancel timer in `anything-cleanup'.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.149  2009/02/20 12:23:44  rubikitch</span>
<span class="linecomment">;; `anything-header' face now inherits header-line (not a copy).</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.148  2009/02/16 23:40:22  rubikitch</span>
<span class="linecomment">;; `real-to-display' attribute bug fix.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.147  2009/02/02 20:51:41  rubikitch</span>
<span class="linecomment">;; New `anything-sources' attribute: real-to-display</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.146  2009/02/01 20:01:00  rubikitch</span>
<span class="linecomment">;; Update Tips</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.145  2009/02/01 19:45:53  rubikitch</span>
<span class="linecomment">;; New variable: `anything-quit-if-no-candidate'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.144  2009/02/01 19:31:47  rubikitch</span>
<span class="linecomment">;; fixed a typo</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.143  2009/02/01 19:23:32  rubikitch</span>
<span class="linecomment">;; New variable: `anything-execute-action-at-once-if-one'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.142  2009/02/01 19:12:34  rubikitch</span>
<span class="linecomment">;; `anything-persistent-action-display-buffer': bug fix</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.141  2009/02/01 18:25:25  rubikitch</span>
<span class="linecomment">;; * fix docstring</span>
<span class="linecomment">;; * New variable: `anything-selection-face'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.140  2009/01/16 16:36:25  rubikitch</span>
<span class="linecomment">;; New variable: `anything-persistent-action-use-special-display'.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.139  2009/01/05 20:15:53  rubikitch</span>
<span class="linecomment">;; Fixed a bug of anything action buffer.</span>
<span class="linecomment">;; The action source should not be cached.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.138  2008/12/21 16:56:05  rubikitch</span>
<span class="linecomment">;; Fixed an error when action attribute is a function symbol and press TAB,</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.137  2008/12/20 19:38:47  rubikitch</span>
<span class="linecomment">;; `anything-check-minibuffer-input-1': proper quit handling</span>
<span class="linecomment">;; `anything-process-delayed-sources': ditto</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.136  2008/10/27 17:41:27  rubikitch</span>
<span class="linecomment">;; `anything-process-delayed-sources', `anything-check-minibuffer-input-1': quittable</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.135  2008/10/27 17:04:25  rubikitch</span>
<span class="linecomment">;; arranged source, added more linkd tags (no code change)</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.134  2008/10/27 15:02:25  rubikitch</span>
<span class="linecomment">;; New variable: `anything-save-configuration-functions'</span>
<span class="linecomment">;; Delete variable: `anything-save-configuration-type'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.133  2008/10/27 11:16:13  rubikitch</span>
<span class="linecomment">;; New variable: `anything-save-configuration-type'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.132  2008/10/26 22:34:59  rubikitch</span>
<span class="linecomment">;; `anything-delete-current-selection' with multiline</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.131  2008/10/26 21:44:43  rubikitch</span>
<span class="linecomment">;; New command: `anything-delete-current-selection'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.130  2008/10/22 10:41:09  rubikitch</span>
<span class="linecomment">;; `anything-insert-match': do not override 'anything-realvalue property</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.129  2008/10/21 17:01:37  rubikitch</span>
<span class="linecomment">;; `anything-resume' per buffer.</span>
<span class="linecomment">;; `anything-last-sources': obsolete</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.128  2008/10/20 06:27:54  rubikitch</span>
<span class="linecomment">;; `anything-quick-update': new user option</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.127  2008/10/20 05:47:49  rubikitch</span>
<span class="linecomment">;; refactoring</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.126  2008/10/20 03:47:58  rubikitch</span>
<span class="linecomment">;; `anything-update': reversed order of delayed sources</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.125  2008/10/19 00:29:54  rubikitch</span>
<span class="linecomment">;; kill buffer-local candidate buffers when creating global candidate buffers.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.124  2008/10/18 13:04:20  rubikitch</span>
<span class="linecomment">;; Remove tick entry from `anything-tick-hash' when killing a buffer.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.123  2008/10/18 10:23:36  rubikitch</span>
<span class="linecomment">;; multiline patch by Tomohiro MATSUYAMA.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.122  2008/10/13 03:10:07  rubikitch</span>
<span class="linecomment">;; `anything': do `anything-mark-current-line' when resuming</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.121  2008/10/13 03:08:08  rubikitch</span>
<span class="linecomment">;; always set `anything-current-position'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.120  2008/10/07 14:12:02  rubikitch</span>
<span class="linecomment">;; `anything-execute-persistent-action': optional arg</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.119  2008/10/06 06:43:29  rubikitch</span>
<span class="linecomment">;; `anything-candidate-buffer': return nil when the buffer is dead</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.118  2008/09/30 22:21:28  rubikitch</span>
<span class="linecomment">;; New `anything-sources' attribute: accept-empty</span>
<span class="linecomment">;; dummy: include accept-empty</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.117  2008/09/30 21:59:10  rubikitch</span>
<span class="linecomment">;; New function: `anything-buffer-is-modified'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.116  2008/09/22 11:27:29  rubikitch</span>
<span class="linecomment">;; *** empty log message ***</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.115  2008/09/20 20:21:11  rubikitch</span>
<span class="linecomment">;; added linkd index. (no code change)</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.114  2008/09/20 20:09:57  rubikitch</span>
<span class="linecomment">;; INCOMPATIBLE CHANGES: `anything-attr'</span>
<span class="linecomment">;; New functions: `anything-attrset', `anything-attr-defined'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.113  2008/09/14 15:15:32  rubikitch</span>
<span class="linecomment">;; bugfix: volatile and match attribute / process and match attribute</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.112  2008/09/12 01:57:17  rubikitch</span>
<span class="linecomment">;; When resuming anything, reinitialize overlays.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.111  2008/09/10 22:53:11  rubikitch</span>
<span class="linecomment">;; anything: bug fix of `anything-buffer'</span>
<span class="linecomment">;; New macro: `anything-test-update'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.110  2008/09/10 22:17:11  rubikitch</span>
<span class="linecomment">;; New `anything-sources' attribute: header-name</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.109  2008/09/10 21:12:26  rubikitch</span>
<span class="linecomment">;; New hook: `anything-after-action-hook'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.108  2008/09/06 06:07:56  rubikitch</span>
<span class="linecomment">;; Extended `anything-set-sources' optional arguments.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.107  2008/09/05 03:14:35  rubikitch</span>
<span class="linecomment">;; reimplement `anything-current-buffer-is-modified' in the right way</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.106  2008/09/05 00:11:05  rubikitch</span>
<span class="linecomment">;; Moved `anything-read-string-mode' and read functions to anything-complete.el.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.105  2008/09/04 12:45:06  rubikitch</span>
<span class="linecomment">;; New hook: `anything-after-persistent-action-hook'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.104  2008/09/04 12:27:05  rubikitch</span>
<span class="linecomment">;; `anything': prefixed optional arguments</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.103  2008/09/04 09:16:28  rubikitch</span>
<span class="linecomment">;; fixed a bug of `anything-read-file-name'.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.102  2008/09/03 11:25:19  rubikitch</span>
<span class="linecomment">;; Extended `anything' optional arguments: buffer</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.101  2008/09/03 11:15:13  rubikitch</span>
<span class="linecomment">;; `anything': return nil when keybord-quitted</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.100  2008/09/01 23:11:02  rubikitch</span>
<span class="linecomment">;; bug fix of search-from-end</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.99  2008/09/01 13:45:55  rubikitch</span>
<span class="linecomment">;; bug fix of search-from-end</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.98  2008/09/01 11:23:38  rubikitch</span>
<span class="linecomment">;; New `anything-sources' attribute: search-from-end</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.97  2008/09/01 00:44:34  rubikitch</span>
<span class="linecomment">;; Make sure to display the other window when persistent action.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.96  2008/08/31 20:55:20  rubikitch</span>
<span class="linecomment">;; define `buffer-modified-tick' for older emacs.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.95  2008/08/30 04:55:51  rubikitch</span>
<span class="linecomment">;; fixed a bug of `anything-completing-read'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.94  2008/08/28 20:18:03  rubikitch</span>
<span class="linecomment">;; added some tests</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.93  2008/08/25 20:18:46  rubikitch</span>
<span class="linecomment">;; `anything': set `anything-input' and `anything-pattern' before `anything-update'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.92  2008/08/24 22:38:46  rubikitch</span>
<span class="linecomment">;; *** empty log message ***</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.91  2008/08/24 21:34:35  rubikitch</span>
<span class="linecomment">;; rewrite `with-anything-restore-variables'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.90  2008/08/24 20:33:02  rubikitch</span>
<span class="linecomment">;; prevent the unit test from byte-compiled.</span>
<span class="linecomment">;; macro bug fix.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.89  2008/08/24 08:35:27  rubikitch</span>
<span class="linecomment">;; *** empty log message ***</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.88  2008/08/24 08:22:19  rubikitch</span>
<span class="linecomment">;; Rename `anything-candidates-buffer' -&gt; `anything-candidate-buffer'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.87  2008/08/23 22:27:04  rubikitch</span>
<span class="linecomment">;; New hook: `anything-cleanup-hook'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.86  2008/08/23 22:05:42  rubikitch</span>
<span class="linecomment">;; `anything-original-source-filter' is removed.</span>
<span class="linecomment">;; Now use `anything-restored-variables' and `with-anything-restore-variables'.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.85  2008/08/23 21:23:21  rubikitch</span>
<span class="linecomment">;; inhibit-read-only = t in anything-buffer</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.84  2008/08/23 21:18:33  rubikitch</span>
<span class="linecomment">;; *** empty log message ***</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.83  2008/08/23 20:44:20  rubikitch</span>
<span class="linecomment">;; `anything-execute-persistent-action': display-to-real bug fix</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.82  2008/08/23 20:19:12  rubikitch</span>
<span class="linecomment">;; New `anything-sources' attribute: get-line</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.81  2008/08/23 19:32:14  rubikitch</span>
<span class="linecomment">;; `anything-attr': Return t in (attribute-name) case.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.80  2008/08/22 21:25:05  rubikitch</span>
<span class="linecomment">;; anything-candidates-in-buffer-1:</span>
<span class="linecomment">;; Open a line at the BOB to make use of `search-forward' for faster exact/prefix match.</span>
<span class="linecomment">;; Of course, restore the buffer contents after search.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.79  2008/08/22 17:11:00  rubikitch</span>
<span class="linecomment">;; New hook: `anything-before-initialize-hook', `anything-after-initialize-hook'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.78  2008/08/21 18:37:03  rubikitch</span>
<span class="linecomment">;; Implemented dummy sources as plug-in.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.77  2008/08/21 17:40:40  rubikitch</span>
<span class="linecomment">;; New function: `anything-set-sources'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.76  2008/08/21 12:25:02  rubikitch</span>
<span class="linecomment">;; New variable: `anything-version'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.75  2008/08/21 12:13:46  rubikitch</span>
<span class="linecomment">;; New variable: `anything-in-persistent-action'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.74  2008/08/21 10:34:22  rubikitch</span>
<span class="linecomment">;; New function `anything-mklist'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.73  2008/08/21 09:41:38  rubikitch</span>
<span class="linecomment">;; accept multiple init/cleanup functions so that plug-ins can add new function.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.72  2008/08/20 22:51:53  rubikitch</span>
<span class="linecomment">;; New `anything-sources' attribute: candidate-number-limit</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.71  2008/08/20 21:45:42  rubikitch</span>
<span class="linecomment">;; added many tests.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.70  2008/08/20 18:51:45  rubikitch</span>
<span class="linecomment">;; `anything-preselect' bug fix.</span>
<span class="linecomment">;; refactoring.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.69  2008/08/20 17:57:51  rubikitch</span>
<span class="linecomment">;; Extended `anything' optional arguments: preselect</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.68  2008/08/20 16:39:07  rubikitch</span>
<span class="linecomment">;; Nested `anything' invocation support, ie. `anything' can be invoked by anything action.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; (anything '(((name . "nested anything invocation test")</span>
<span class="linecomment">;;              (candidates "anything-c-source-buffers" "anything-c-source-man-pages")</span>
<span class="linecomment">;;              (display-to-real . intern)</span>
<span class="linecomment">;;              (action . anything))))</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.67  2008/08/20 00:08:28  rubikitch</span>
<span class="linecomment">;; `anything-candidates-in-buffer-1': add code when pattern == ""</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.66  2008/08/19 23:31:52  rubikitch</span>
<span class="linecomment">;; Removed `anything-show-exact-match-first' because it should be provided as a plug-in.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.65  2008/08/19 23:18:47  rubikitch</span>
<span class="linecomment">;; *** empty log message ***</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.64  2008/08/19 23:15:43  rubikitch</span>
<span class="linecomment">;; `anything-compute-matches': short-cut when match == '(identity)</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.63  2008/08/19 23:06:42  rubikitch</span>
<span class="linecomment">;; Use hash table to speed uniquify candidates.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.62  2008/08/19 22:40:57  rubikitch</span>
<span class="linecomment">;; `anything-test-candidates': additional optonal argument</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.61  2008/08/19 18:13:39  rubikitch</span>
<span class="linecomment">;; search attribute: multiple search functions</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.60  2008/08/19 15:07:39  rubikitch</span>
<span class="linecomment">;; New function: `anything-attr'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.59  2008/08/19 15:01:59  rubikitch</span>
<span class="linecomment">;; arranged code</span>
<span class="linecomment">;; added unit tests</span>
<span class="linecomment">;; update doc</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.58  2008/08/19 13:40:52  rubikitch</span>
<span class="linecomment">;; `anything-get-current-source': This function can be used in</span>
<span class="linecomment">;;  init/candidates/action/candidate-transformer/filtered-candidate-transformer</span>
<span class="linecomment">;;  display-to-real/cleanup function.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.57  2008/08/19 03:43:57  rubikitch</span>
<span class="linecomment">;; `anything-process-delayed-sources': delay = anything-idle-delay - anything-input-idle-delay</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.56  2008/08/18 06:37:51  rubikitch</span>
<span class="linecomment">;; Make `anything-input-idle-delay' ineffective when the action list is shown.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.55  2008/08/18 06:35:00  rubikitch</span>
<span class="linecomment">;; New variable: `anything-show-exact-match-first'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.54  2008/08/17 23:22:24  rubikitch</span>
<span class="linecomment">;; *** empty log message ***</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.53  2008/08/17 23:15:38  rubikitch</span>
<span class="linecomment">;; bind `anything-source-name' when executing action to enable to use `anything-candidate-buffer' in action.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.52  2008/08/17 15:21:27  rubikitch</span>
<span class="linecomment">;; `anything-test-candidates': accept a symbol for source</span>
<span class="linecomment">;; New variable: `anything-input-idle-delay'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.51  2008/08/17 12:45:30  rubikitch</span>
<span class="linecomment">;; (buffer-disable-undo) in anything-buffer</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.50  2008/08/16 22:21:37  rubikitch</span>
<span class="linecomment">;; `anything-saved-sources': removed</span>
<span class="linecomment">;; `anything-action-buffer': action selection buffer</span>
<span class="linecomment">;; `anything-select-action': toggle actions &lt;=&gt; candidates</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.49  2008/08/16 19:46:11  rubikitch</span>
<span class="linecomment">;; New function: `anything-action-list-is-shown'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.48  2008/08/16 17:03:02  rubikitch</span>
<span class="linecomment">;; bugfix: cleanup</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.47  2008/08/16 16:35:24  rubikitch</span>
<span class="linecomment">;; silence byte compiler</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.46  2008/08/16 14:51:27  rubikitch</span>
<span class="linecomment">;; *** empty log message ***</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.45  2008/08/16 11:27:59  rubikitch</span>
<span class="linecomment">;; refactoring</span>
<span class="linecomment">;;  `anything-aif': Anaphoric if.</span>
<span class="linecomment">;;  `anything-compile-source-functions': make `anything-get-sources' customizable.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.44  2008/08/16 09:38:15  rubikitch</span>
<span class="linecomment">;; *** empty log message ***</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.43  2008/08/15 11:44:28  rubikitch</span>
<span class="linecomment">;; `anything-read-string-mode': minor mode for `anything' version of read functions. (experimental)</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.42  2008/08/15 11:03:20  rubikitch</span>
<span class="linecomment">;; update docs</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.41  2008/08/14 20:51:28  rubikitch</span>
<span class="linecomment">;; New `anything-sources' attribute: cleanup</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.40  2008/08/14 10:34:04  rubikitch</span>
<span class="linecomment">;; `anything': SOURCES: accept symbols</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.39  2008/08/10 22:46:01  rubikitch</span>
<span class="linecomment">;; `anything-move-selection': avoid infinite loop</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.38  2008/08/09 21:38:25  rubikitch</span>
<span class="linecomment">;; `anything-read-file-name': experimental implementation.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.37  2008/08/09 17:54:25  rubikitch</span>
<span class="linecomment">;; action test</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.36  2008/08/09 17:13:00  rubikitch</span>
<span class="linecomment">;; fixed test</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.35  2008/08/09 10:43:08  rubikitch</span>
<span class="linecomment">;; New `anything-sources' attribute: display-to-real</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.34  2008/08/07 13:15:44  rubikitch</span>
<span class="linecomment">;; New `anything-sources' attribute: search</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.33  2008/08/05 23:14:20  rubikitch</span>
<span class="linecomment">;; `anything-candidate-buffer': bugfix</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.32  2008/08/05 21:42:15  rubikitch</span>
<span class="linecomment">;; *** empty log message ***</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.31  2008/08/05 21:06:23  rubikitch</span>
<span class="linecomment">;; `anything-candidate-buffer': candidates buffer registration</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.30  2008/08/05 19:46:36  rubikitch</span>
<span class="linecomment">;; New `anything-sources' attribute: candidates-in-buffer</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.29  2008/08/05 17:58:31  rubikitch</span>
<span class="linecomment">;; *** empty log message ***</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.28  2008/08/05 17:46:04  rubikitch</span>
<span class="linecomment">;; memoized `anything-get-sources'</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.27  2008/08/05 17:29:40  rubikitch</span>
<span class="linecomment">;; update doc</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.26  2008/08/05 08:35:45  rubikitch</span>
<span class="linecomment">;; `anything-completing-read': accept obarray</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.25  2008/08/05 07:26:17  rubikitch</span>
<span class="linecomment">;; `anything-completing-read': guard from non-string return value</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.24  2008/08/04 12:05:41  rubikitch</span>
<span class="linecomment">;; Wrote Tips and some docstrings.</span>
<span class="linecomment">;; `anything-candidate-buffer': buffer-local by default</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.23  2008/08/04 05:29:46  rubikitch</span>
<span class="linecomment">;; `anything-buffer-file-name': `buffer-file-name' when `anything' is invoked.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.22  2008/08/04 00:10:13  rubikitch</span>
<span class="linecomment">;; `anything-candidate-buffer': new API</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.21  2008/08/03 22:05:08  rubikitch</span>
<span class="linecomment">;; `anything-candidate-buffer': Return a buffer containing candidates of current source.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.20  2008/08/03 20:47:56  rubikitch</span>
<span class="linecomment">;; `anything-current-buffer-is-modified': modify checker</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.19  2008/08/03 19:06:18  rubikitch</span>
<span class="linecomment">;; `anything-candidates-in-buffer': use `with-current-buffer' instead.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.18  2008/08/03 05:55:01  rubikitch</span>
<span class="linecomment">;; `anything-candidates-in-buffer': extract candidates in a buffer for speed.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.17  2008/08/02 21:31:29  rubikitch</span>
<span class="linecomment">;; Extended `anything' optional arguments.</span>
<span class="linecomment">;; `anything-completing-read': experimental implementation.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.16  2008/08/02 20:32:54  rubikitch</span>
<span class="linecomment">;; Extended `anything' optional arguments.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.15  2008/08/02 16:53:40  rubikitch</span>
<span class="linecomment">;; Fixed a small bug of `anything-test-candidates'.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.14  2008/08/02 16:48:29  rubikitch</span>
<span class="linecomment">;; Refactored to testable code.</span>
<span class="linecomment">;; Added many candidate tests with `anything-test-candidates'.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.13  2008/08/02 15:08:14  rubikitch</span>
<span class="linecomment">;; *** empty log message ***</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.12  2008/08/02 14:29:31  rubikitch</span>
<span class="linecomment">;; `anything-sources' accepts symbols. (patched by Sugawara)</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.11  2008/08/02 10:20:36  rubikitch</span>
<span class="linecomment">;; `anything-resume' is usable with other (let-binded) `anything-sources'.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.10  2008/08/01 19:44:01  rubikitch</span>
<span class="linecomment">;; `anything-resume': resurrect previously invoked `anything'.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.9  2008/07/30 15:44:49  rubikitch</span>
<span class="linecomment">;; *** empty log message ***</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.8  2008/07/30 15:38:51  rubikitch</span>
<span class="linecomment">;; *** empty log message ***</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.7  2008/07/30 15:21:48  rubikitch</span>
<span class="linecomment">;; `anything-scroll-other-window', `anything-scroll-other-window-down':</span>
<span class="linecomment">;; Scroll other window (for persistent action).</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.6  2008/07/30 15:12:36  rubikitch</span>
<span class="linecomment">;; *** empty log message ***</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.5  2008/07/30 15:06:32  rubikitch</span>
<span class="linecomment">;; `anything-select-2nd-action', `anything-select-3rd-action', `anything-select-4th-action':</span>
<span class="linecomment">;; Select other than default action without pressing Tab.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.4  2008/07/30 14:58:27  rubikitch</span>
<span class="linecomment">;; `anything-current-buffer': Store current buffer when `anything' is invoked.</span>
<span class="linecomment">;; `anything-current-position': Restore position when keyboard-quitted.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.3  2008/07/30 14:38:04  rubikitch</span>
<span class="linecomment">;; Implemented persistent action.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.2  2008/07/30 13:37:16  rubikitch</span>
<span class="linecomment">;; Update doc.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Revision 1.1  2008/07/30 13:22:06  rubikitch</span>
<span class="linecomment">;; New maintainer.</span>
<span class="linecomment">;;</span>

(defvar anything-version "<span class="quote">$Id: anything.el,v 1.201 2009/08/08 13:25:30 rubikitch Exp rubikitch $</span>")
(require 'cl)

<span class="linecomment">;; (@* "User Configuration")</span>

<span class="linecomment">;; This is only an example. Customize it to your own taste!</span>
(defvar anything-sources `(((name . "<span class="quote">Buffers</span>")
                            (candidates
                             . (lambda ()
                                 (remove-if (lambda (name)
                                              (or (equal name anything-buffer)
                                                  (eq ?\  (aref name 0))))
                                            (mapcar 'buffer-name (buffer-list)))))
			    (type . buffer))

                           ((name . "<span class="quote">File Name History</span>")
                            (candidates . file-name-history)
                            (match (lambda (candidate)
                                     <span class="linecomment">;; list basename matches first</span>
                                     (string-match 
                                      anything-pattern 
                                      (file-name-nondirectory candidate)))

                                   (lambda (candidate)                                     
                                     <span class="linecomment">;; and then directory part matches</span>
                                     (let ((dir (file-name-directory candidate)))
                                       (if dir
                                           (string-match anything-pattern dir)))))
                            (type . file))

                           ((name . "<span class="quote">Files from Current Directory</span>")
                            (init . (lambda ()
                                      (setq anything-default-directory
                                            default-directory)))
                            (candidates . (lambda ()
                                            (directory-files
                                             anything-default-directory)))
                            (type . file))

                           ((name . "<span class="quote">Manual Pages</span>")
                            (candidates . ,(progn
                                             <span class="linecomment">;; XEmacs doesn't have a woman :)</span>
                                             (declare (special woman-file-name
                                                               woman-topic-all-completions))
                                             (condition-case nil
                                                 (progn
                                                   (require 'woman)
                                                   (woman-file-name "<span class="quote"></span>")
                                                   (sort (mapcar 'car
                                                                 woman-topic-all-completions)
                                                         'string-lessp))
                                               (error nil))))
                            (action . (("<span class="quote">Open Manual Page</span>" . woman)))
                            (requires-pattern . 2))

                           ((name . "<span class="quote">Complex Command History</span>")
                            (candidates . (lambda ()
                                            (mapcar 'prin1-to-string
                                                    command-history)))
                            (action . (("<span class="quote">Repeat Complex Command</span>" . 
                                        (lambda (c)
                                          (eval (read c))))))
                            (delayed)))
  "<span class="quote">The source of candidates for anything.
It accepts symbols:
 (setq anything-sources (list anything-c-foo anything-c-bar))
can be written as
 (setq anything-sources '(anything-c-foo anything-c-bar))
The latter is recommended because if you change anything-c-* variable,
you do not have to update `anything-sources'.

If you want to change `anything-sources' during `anything' invocation,
use `anything-set-sources', never use `setq'.

Attributes:

- name (mandatory)

  The name of the source. It is also the heading which appears
  above the list of matches from the source. Must be unique.

- header-name (optional)

  A function returning the display string of the header. Its
  argument is the name of the source. This attribute is useful to
  add an additional information with the source name.

- candidates (mandatory if candidates-in-buffer attribute is not provided)

  Specifies how to retrieve candidates from the source. It can
  either be a variable name, a function called with no parameters
  or the actual list of candidates.

  The list must be a list whose members are strings, symbols
  or (DISPLAY . REAL) pairs.

  In case of (DISPLAY . REAL) pairs, the DISPLAY string is shown
  in the Anything buffer, but the REAL one is used as action
  argument when the candidate is selected. This allows a more
  readable presentation for candidates which would otherwise be,
  for example, too long or have a common part shared with other
  candidates which can be safely replaced with an abbreviated
  string for display purposes.

  Note that if the (DISPLAY . REAL) form is used then pattern
  matching is done on the displayed string, not on the real
  value.

  If the candidates have to be retrieved asynchronously (for
  example, by an external command which takes a while to run)
  then the function should start the external command
  asynchronously and return the associated process object.
  Anything will take care of managing the process (receiving the
  output from it, killing it if necessary, etc.). The process
  should return candidates matching the current pattern (see
  variable `anything-pattern'.)

  Note that currently results from asynchronous sources appear
  last in the anything buffer regardless of their position in
  `anything-sources'.

- action (mandatory if type attribute is not provided)

  It is a list of (DISPLAY . FUNCTION) pairs or FUNCTION.
  FUNCTION is called with one parameter: the selected candidate.

  An action other than the default can be chosen from this list
  of actions for the currently selected candidate (by default
  with TAB). The DISPLAY string is shown in the completions
  buffer and the FUNCTION is invoked when an action is
  selected. The first action of the list is the default.

- type (optional if action attribute is provided)

  Indicates the type of the items the source returns. 

  Merge attributes not specified in the source itself from
  `anything-type-attributes'.

  This attribute is implemented by plug-in.

- init (optional)

  Function called with no parameters when anything is started. It
  is useful for collecting current state information which can be
  used to create the list of candidates later.

  For example, if a source needs to work with the current
  directory then it can store its value here, because later
  anything does its job in the minibuffer and in the
  `anything-buffer' and the current directory can be different
  there.

- match (optional)

  List of functions called with one parameter: a candidate. The
  function should return non-nil if the candidate matches the
  current pattern (see variable `anything-pattern').

  This attribute allows the source to override the default
  pattern matching based on `string-match'. It can be used, for
  example, to implement a source for file names and do the
  pattern matching on the basename of files, since it's more
  likely one is typing part of the basename when searching for a
  file, instead of some string anywhere else in its path.

  If the list contains more than one function then the list of
  matching candidates from the source is constructed by appending
  the results after invoking the first function on all the
  potential candidates, then the next function, and so on. The
  matching candidates supplied by the first function appear first
  in the list of results and then results from the other
  functions, respectively.

  This attribute has no effect for asynchronous sources (see
  attribute `candidates'), since they perform pattern matching
  themselves.

- candidate-transformer (optional)

  It's a function or a list of functions called with one argument
  when the completion list from the source is built. The argument
  is the list of candidates retrieved from the source. The
  function should return a transformed list of candidates which
  will be used for the actual completion.  If it is a list of
  functions, it calls each function sequentially.

  This can be used to transform or remove items from the list of
  candidates.

  Note that `candidates' is run already, so the given transformer
  function should also be able to handle candidates with (DISPLAY
  . REAL) format.

- filtered-candidate-transformer (optional)

  It has the same format as `candidate-transformer', except the
  function is called with two parameters: the candidate list and
  the source.

  This transformer is run on the candidate list which is already
  filtered by the current pattern. While `candidate-transformer'
  is run only once, it is run every time the input pattern is
  changed.

  It can be used to transform the candidate list dynamically, for
  example, based on the current pattern.

  In some cases it may also be more efficent to perform candidate
  transformation here, instead of with `candidate-transformer'
  even if this transformation is done every time the pattern is
  changed.  For example, if a candidate set is very large then
  `candidate-transformer' transforms every candidate while only
  some of them will actually be dislpayed due to the limit
  imposed by `anything-candidate-number-limit'.

  Note that `candidates' and `candidate-transformer' is run
  already, so the given transformer function should also be able
  to handle candidates with (DISPLAY . REAL) format.

  This option has no effect for asynchronous sources. (Not yet,
  at least.

- action-transformer (optional)

  It's a function or a list of functions called with two
  arguments when the action list from the source is
  assembled. The first argument is the list of actions, the
  second is the current selection.  If it is a list of functions,
  it calls each function sequentially.

  The function should return a transformed action list.

  This can be used to customize the list of actions based on the
  currently selected candidate.

- delayed (optional)

  Candidates from the source are shown only if the user stops
  typing and is idle for `anything-idle-delay' seconds.

- volatile (optional)

  Indicates the source assembles the candidate list dynamically,
  so it shouldn't be cached within a single Anything
  invocation. It is only applicable to synchronous sources,
  because asynchronous sources are not cached.

- requires-pattern (optional)

  If present matches from the source are shown only if the
  pattern is not empty. Optionally, it can have an integer
  parameter specifying the required length of input which is
  useful in case of sources with lots of candidates.

- persistent-action (optional)

  Function called with one parameter; the selected candidate.

  An action performed by `anything-execute-persistent-action'.
  If none, use the default action.

- candidates-in-buffer (optional)

  Shortcut attribute for making and narrowing candidates using
  buffers.  This newly-introduced attribute prevents us from
  forgetting to add volatile and match attributes.

  See docstring of `anything-candidates-in-buffer'.

  (candidates-in-buffer) is equivalent of three attributes:
    (candidates . anything-candidates-in-buffer)
    (volatile)
    (match identity)

  (candidates-in-buffer . candidates-function) is equivalent of:
    (candidates . candidates-function)
    (volatile)
    (match identity)

  This attribute is implemented by plug-in.

- search (optional)

  List of functions like `re-search-forward' or `search-forward'.
  Buffer search function used by `anything-candidates-in-buffer'.
  By default, `anything-candidates-in-buffer' uses `re-search-forward'.
  This attribute is meant to be used with
  (candidates . anything-candidates-in-buffer) or
  (candidates-in-buffer) in short.

- search-from-end (optional)

  Make `anything-candidates-in-buffer' search from the end of buffer.
  If this attribute is specified, `anything-candidates-in-buffer' uses
  `re-search-backward' instead.

- get-line (optional)

  A function like `buffer-substring-no-properties' or `buffer-substring'.
  This function converts point of line-beginning and point of line-end,
  which represents a candidate computed by `anything-candidates-in-buffer'.
  By default, `anything-candidates-in-buffer' uses
  `buffer-substring-no-properties'.

- display-to-real (optional)

  Function called with one parameter; the selected candidate.

  The function transforms the selected candidate, and the result
  is passed to the action function.  The display-to-real
  attribute provides another way to pass other string than one
  shown in Anything buffer.

  Traditionally, it is possible to make candidates,
  candidate-transformer or filtered-candidate-transformer
  function return a list with (DISPLAY . REAL) pairs. But if REAL
  can be generated from DISPLAY, display-to-real is more
  convenient and faster.

- real-to-display (optional)

  Function called with one parameter; the selected candidate.

  The inverse of display-to-real attribute.

  The function transforms the selected candidate, which is passed
  to the action function, for display.  The real-to-display
  attribute provides the other way to pass other string than one
  shown in Anything buffer.

  Traditionally, it is possible to make candidates,
  candidate-transformer or filtered-candidate-transformer
  function return a list with (DISPLAY . REAL) pairs. But if
  DISPLAY can be generated from REAL, real-to-display is more
  convenient and faster.

- cleanup (optional)

  Function called with no parameters when *anything* buffer is closed. It
  is useful for killing unneeded candidates buffer.

  Note that the function is executed BEFORE performing action.

- candidate-number-limit (optional)

  Override `anything-candidate-number-limit' only for this source.

- accept-empty (optional)

  Pass empty string \"\" to action function.

- dummy (optional)

  Set `anything-pattern' to candidate. If this attribute is
  specified, The candidates attribute is ignored.

  This attribute is implemented by plug-in.

- multiline (optional)

  Enable to selection multiline candidates.
</span>")


<span class="linecomment">;; This value is only provided as an example. Customize it to your own</span>
<span class="linecomment">;; taste!</span>
(defvar anything-type-attributes
  '((file (action . (("<span class="quote">Find File</span>" . find-file)
                     ("<span class="quote">Delete File</span>" . (lambda (file)
                                        (if (y-or-n-p (format "<span class="quote">Really delete file %s? </span>"
                                                              file))
                                            (delete-file file)))))))
    (buffer (action . (("<span class="quote">Switch to Buffer</span>" . switch-to-buffer)
                       ("<span class="quote">Pop to Buffer</span>"    . pop-to-buffer)
                       ("<span class="quote">Display Buffer</span>"   . display-buffer)
                       ("<span class="quote">Kill Buffer</span>"      . kill-buffer)))))
  "<span class="quote">It's a list of (TYPE ATTRIBUTES ...). ATTRIBUTES are the same
  as attributes for `anything-sources'. TYPE connects the value
  to the appropriate sources in `anything-sources'.

  This allows specifying common attributes for several
  sources. For example, sources which provide files can specify
  common attributes with a `file' type.</span>")


(defvar anything-enable-digit-shortcuts nil
  "<span class="quote">*If t then the first nine matches can be selected using
  Ctrl+&lt;number&gt;.</span>")

(defvar anything-display-source-at-screen-top t
  "<span class="quote">*If t, `anything-next-source' and `anything-previous-source'
  display candidates at the top of screen.</span>")

(defvar anything-candidate-number-limit 50
  "<span class="quote">*Do not show more candidates than this limit from individual
  sources. It is usually pointless to show hundreds of matches
  when the pattern is empty, because it is much simpler to type a
  few characters to narrow down the list of potential candidates.

  Set it to nil if you don't want this limit.</span>")


(defvar anything-idle-delay 0.5
  "<span class="quote">*The user has to be idle for this many seconds, before
  candidates from delayed sources are collected. This is useful
  for sources involving heavy operations (like launching external
  programs), so that candidates from the source are not retrieved
  unnecessarily if the user keeps typing.

  It also can be used to declutter the results anything displays,
  so that results from certain sources are not shown with every
  character typed, only if the user hesitates a bit.</span>")


(defvar anything-input-idle-delay 0.1
  "<span class="quote">The user has to be idle for this many seconds, before ALL candidates are collected.
Unlink `anything-input-idle', it is also effective for non-delayed sources.
If nil, candidates are collected immediately. </span>")


(defvar anything-samewindow nil
  "<span class="quote">If t then Anything doesn't pop up a new window, it uses the
current window to show the candidates.</span>")


(defvar anything-source-filter nil
  "<span class="quote">A list of source names to be displayed. Other sources won't
appear in the search results. If nil then there is no filtering.
See also `anything-set-source-filter'.</span>")


(defvar anything-map
  (let ((map (copy-keymap minibuffer-local-map)))
    (define-key map (kbd "<span class="quote">&lt;down&gt;</span>") 'anything-next-line)
    (define-key map (kbd "<span class="quote">&lt;up&gt;</span>") 'anything-previous-line)
    (define-key map (kbd "<span class="quote">C-n</span>")     'anything-next-line)
    (define-key map (kbd "<span class="quote">C-p</span>")     'anything-previous-line)
    (define-key map (kbd "<span class="quote">&lt;prior&gt;</span>") 'anything-previous-page)
    (define-key map (kbd "<span class="quote">&lt;next&gt;</span>") 'anything-next-page)
    (define-key map (kbd "<span class="quote">M-v</span>")     'anything-previous-page)
    (define-key map (kbd "<span class="quote">C-v</span>")     'anything-next-page)
    (define-key map (kbd "<span class="quote">&lt;right&gt;</span>") 'anything-next-source)
    (define-key map (kbd "<span class="quote">&lt;left&gt;</span>") 'anything-previous-source)
    (define-key map (kbd "<span class="quote">&lt;RET&gt;</span>") 'anything-exit-minibuffer)
    (define-key map (kbd "<span class="quote">C-1</span>") 'anything-select-with-digit-shortcut)
    (define-key map (kbd "<span class="quote">C-2</span>") 'anything-select-with-digit-shortcut)
    (define-key map (kbd "<span class="quote">C-3</span>") 'anything-select-with-digit-shortcut)
    (define-key map (kbd "<span class="quote">C-4</span>") 'anything-select-with-digit-shortcut)
    (define-key map (kbd "<span class="quote">C-5</span>") 'anything-select-with-digit-shortcut)
    (define-key map (kbd "<span class="quote">C-6</span>") 'anything-select-with-digit-shortcut)
    (define-key map (kbd "<span class="quote">C-7</span>") 'anything-select-with-digit-shortcut)
    (define-key map (kbd "<span class="quote">C-8</span>") 'anything-select-with-digit-shortcut)
    (define-key map (kbd "<span class="quote">C-9</span>") 'anything-select-with-digit-shortcut)
    (define-key map (kbd "<span class="quote">C-i</span>") 'anything-select-action)
    (define-key map (kbd "<span class="quote">C-z</span>") 'anything-execute-persistent-action)
    (define-key map (kbd "<span class="quote">C-e</span>") 'anything-select-2nd-action-or-end-of-line)
    (define-key map (kbd "<span class="quote">C-j</span>") 'anything-select-3rd-action)
    (define-key map (kbd "<span class="quote">C-o</span>") 'anything-next-source)
    (define-key map (kbd "<span class="quote">C-M-v</span>") 'anything-scroll-other-window)
    (define-key map (kbd "<span class="quote">M-&lt;next&gt;</span>") 'anything-scroll-other-window)
    (define-key map (kbd "<span class="quote">C-M-y</span>") 'anything-scroll-other-window-down)
    (define-key map (kbd "<span class="quote">C-M-S-v</span>") 'anything-scroll-other-window-down)
    (define-key map (kbd "<span class="quote">M-&lt;prior&gt;</span>") 'anything-scroll-other-window-down)
    (define-key map (kbd "<span class="quote">C-SPC</span>") 'anything-toggle-visible-mark)
    (define-key map (kbd "<span class="quote">M-[</span>") 'anything-prev-visible-mark)
    (define-key map (kbd "<span class="quote">M-]</span>") 'anything-next-visible-mark)
    (define-key map (kbd "<span class="quote">C-k</span>") 'anything-delete-minibuffer-content)

    (define-key map (kbd "<span class="quote">C-s</span>") 'anything-isearch)
    (define-key map (kbd "<span class="quote">C-r</span>") 'undefined)
    (define-key map (kbd "<span class="quote">C-x C-f</span>") 'anything-quit-and-find-file)

    (define-key map (kbd "<span class="quote">C-c C-d</span>") 'anything-delete-current-selection)
    (define-key map (kbd "<span class="quote">C-c C-y</span>") 'anything-yank-selection)
    (define-key map (kbd "<span class="quote">C-c C-k</span>") 'anything-kill-selection-and-quit)
    (define-key map (kbd "<span class="quote">C-c C-f</span>") 'anything-follow-mode)

    <span class="linecomment">;; the defalias is needed because commands are bound by name when</span>
    <span class="linecomment">;; using iswitchb, so only commands having the prefix anything-</span>
    <span class="linecomment">;; get rebound</span>
    (defalias 'anything-previous-history-element 'previous-history-element)
    (defalias 'anything-next-history-element 'next-history-element)
    (define-key map (kbd "<span class="quote">M-p</span>") 'anything-previous-history-element)
    (define-key map (kbd "<span class="quote">M-n</span>") 'anything-next-history-element)
    map)
  "<span class="quote">Keymap for anything.

If you execute `anything-iswitchb-setup', some keys are modified.
See `anything-iswitchb-setup-keys'.</span>")

(defvar anything-isearch-map
  (let ((map (make-sparse-keymap)))
    (set-keymap-parent map (current-global-map))
    (define-key map (kbd "<span class="quote">&lt;return&gt;</span>") 'anything-isearch-default-action)
    (define-key map (kbd "<span class="quote">&lt;RET&gt;</span>") 'anything-isearch-default-action)
    (define-key map (kbd "<span class="quote">C-i</span>") 'anything-isearch-select-action)
    (define-key map (kbd "<span class="quote">C-g</span>") 'anything-isearch-cancel)
    (define-key map (kbd "<span class="quote">M-s</span>") 'anything-isearch-again)
    (define-key map (kbd "<span class="quote">&lt;backspace&gt;</span>") 'anything-isearch-delete)
    <span class="linecomment">;; add printing chars</span>
    (loop for i from 32 below 256 do
          (define-key map (vector i) 'anything-isearch-printing-char))
    map)
  "<span class="quote">Keymap for anything incremental search.</span>")


(defgroup anything nil
  "<span class="quote">Open anything.</span>" :prefix "<span class="quote">anything-</span>" :group 'convenience)

(defface anything-header 
  '((t (:inherit header-line))) 
  "<span class="quote">Face for header lines in the anything buffer.</span>" :group 'anything)

(defvar anything-header-face 'anything-header
  "<span class="quote">Face for header lines in the anything buffer.</span>")

(defface anything-isearch-match '((t (:background "<span class="quote">Yellow</span>")))
  "<span class="quote">Face for isearch in the anything buffer.</span>" :group 'anything)

(defvar anything-isearch-match-face 'anything-isearch-match
  "<span class="quote">Face for matches during incremental search.</span>")

(defvar anything-selection-face 'highlight
  "<span class="quote">Face for currently selected item.</span>")

(defvar anything-iswitchb-idle-delay 1
  "<span class="quote">Show anything completions if the user is idle that many
  seconds after typing.</span>")

(defvar anything-iswitchb-dont-touch-iswithcb-keys nil
  "<span class="quote">If t then those commands are not bound from `anything-map'
  under iswitchb which would override standard iswithcb keys.

This allows an even more seamless integration with iswitchb for
those who prefer using iswitchb bindings even if the anything
completions buffer is popped up.

Note that you can bind alternative keys for the same command in
`anything-map', so that you can use different keys for anything
under iswitchb. For example, I bind the character \ to
`anything-exit-minibuffer' which key is just above Enter on my
keyboard. This way I can switch buffers with Enter and choose
anything completions with \.</span>")

<span class="linecomment">;;----------------------------------------------------------------------</span>

(defvar anything-buffer "<span class="quote">*anything*</span>"
  "<span class="quote">Buffer showing completions.</span>")

(defvar anything-action-buffer "<span class="quote">*anything action*</span>"
  "<span class="quote">Buffer showing actions.</span>")

(defvar anything-selection-overlay nil
  "<span class="quote">Overlay used to highlight the currently selected item.</span>")

(defvar anything-isearch-overlay nil
  "<span class="quote">Overlay used to highlight the current match during isearch.</span>")

(defvar anything-digit-overlays nil
  "<span class="quote">Overlays for digit shortcuts. See `anything-enable-digit-shortcuts'.</span>")

(defvar anything-candidate-cache nil
  "<span class="quote">Holds the available candidate withing a single anything invocation.</span>")

(defvar anything-pattern
  "<span class="quote">The input pattern used to update the anything buffer.</span>")

(defvar anything-input
  "<span class="quote">The input typed in the candidates panel.</span>")

(defvar anything-async-processes nil
  "<span class="quote">List of information about asynchronous processes managed by anything.</span>")

(defvar anything-digit-shortcut-count 0
  "<span class="quote">Number of digit shortcuts shown in the anything buffer.</span>")

(defvar anything-before-initialize-hook nil
  "<span class="quote">Run before anything initialization.
This hook is run before init functions in `anything-sources'.</span>")

(defvar anything-after-initialize-hook nil
  "<span class="quote">Run after anything initialization.
Global variables are initialized and the anything buffer is created.
But the anything buffer has no contents. </span>")

(defvar anything-update-hook nil
  "<span class="quote">Run after the anything buffer was updated according the new
  input pattern.</span>")

(defvar anything-cleanup-hook nil
  "<span class="quote">Run after anything minibuffer is closed, IOW this hook is executed BEFORE performing action. </span>")

(defvar anything-after-action-hook nil
  "<span class="quote">Run after executing action.</span>")

(defvar anything-after-persistent-action-hook nil
  "<span class="quote">Run after executing persistent action.</span>")

(defvar anything-restored-variables
  '( anything-candidate-number-limit
     anything-source-filter)
  "<span class="quote">Variables which are restored after `anything' invocation.</span>")
<span class="linecomment">;; `anything-saved-sources' is removed</span>

(defvar anything-saved-selection nil
  "<span class="quote">Saved value of the currently selected object when the action
  list is shown.</span>")

<span class="linecomment">;; `anything-original-source-filter' is removed</span>

(defvar anything-candidate-separator
  "<span class="quote">--------------------</span>"
  "<span class="quote">Candidates separator of `multiline' source.</span>")

(defvar anything-current-buffer nil
  "<span class="quote">Current buffer when `anything' is invoked.</span>")

(defvar anything-buffer-file-name nil
  "<span class="quote">`buffer-file-name' when `anything' is invoked.</span>")

(defvar anything-current-position nil
  "<span class="quote">Cons of (point) and (window-start) when `anything' is invoked.
It is needed because restoring position when `anything' is keyboard-quitted.</span>")

(defvar anything-saved-action nil
  "<span class="quote">Saved value of the currently selected action by key.</span>")

(defvar anything-last-sources nil
  "<span class="quote">OBSOLETE!! Sources of previously invoked `anything'.</span>")

(defvar anything-saved-current-source nil
  "<span class="quote">Saved value of the original (anything-get-current-source) when the action
  list is shown.</span>")

(defvar anything-compiled-sources nil
  "<span class="quote">Compiled version of `anything-sources'. </span>")

(defvar anything-in-persistent-action nil
  "<span class="quote">Flag whether in persistent-action or not.</span>")

(defvar anything-quick-update nil
  "<span class="quote">If non-nil, suppress displaying sources which are out of screen at first.
They are treated as delayed sources at this input.
This flag makes `anything' a bit faster with many sources.</span>")

(defvar anything-last-sources-local nil
  "<span class="quote">Buffer local value of `anything-sources'.</span>")
(defvar anything-last-buffer nil
  "<span class="quote">`anything-buffer' of previously `anything' session.</span>")

(defvar anything-save-configuration-functions
  '(set-frame-configuration . current-frame-configuration)
  "<span class="quote">If you hate flickering, set this variable to
 '(set-window-configuration . current-window-configuration)
</span>")

(defvar anything-persistent-action-use-special-display nil
  "<span class="quote">If non-nil, use `special-display-function' in persistent action.</span>")

(defvar anything-execute-action-at-once-if-one nil
  "<span class="quote">If non-nil and there is one candidate, execute the first action without selection.
It is useful for `anything' applications.</span>")

(defvar anything-quit-if-no-candidate nil
  "<span class="quote">if non-nil and there is no candidate, do not display *anything* buffer and quit.
This variable accepts a function, which is executed if no candidate.

It is useful for `anything' applications.</span>")

(defvar anything-scroll-amount nil
  "<span class="quote">Scroll amount used by `anything-scroll-other-window' and `anything-scroll-other-window-down'.
If you prefer scrolling line by line, set this value to 1.</span>")

(defvar anything-display-function 'anything-default-display-buffer
  "<span class="quote">Function to display *anything* buffer.
It is `anything-default-display-buffer' by default, which affects `anything-samewindow'.</span>")

(put 'anything 'timid-completion 'disabled)

<span class="linecomment">;; (@* "Internal Variables")</span>
(defvar anything-test-candidate-list nil)
(defvar anything-test-mode nil)
(defvar anything-source-name nil)
(defvar anything-candidate-buffer-alist nil)
(defvar anything-check-minibuffer-input-timer nil)
(defvar anything-match-hash (make-hash-table :test 'equal))
(defvar anything-cib-hash (make-hash-table :test 'equal))
(defvar anything-tick-hash (make-hash-table :test 'equal))
(defvar anything-issued-errors nil)

<span class="linecomment">;; (@* "Programming Tools")</span>
(defmacro anything-aif (test-form then-form &rest else-forms)
  "<span class="quote">Anaphoric if. Temporary variable `it' is the result of test-form.</span>"
  `(let ((it ,test-form))
     (if it ,then-form ,@else-forms)))  
(put 'anything-aif 'lisp-indent-function 2)

(defun anything-mklist (obj)
  "<span class="quote">If OBJ is a list, return itself, otherwise make a list with one element.</span>"
  (if (listp obj) obj (list obj)))

<span class="linecomment">;; (@* "Anything API")</span>
(defun anything-buffer-get ()
  "<span class="quote">If *anything action* buffer is shown, return `anything-action-buffer', otherwise `anything-buffer'.</span>"
  (if (anything-action-window)
      anything-action-buffer
    anything-buffer))

(defun anything-window ()
  "<span class="quote">Window of `anything-buffer'.</span>"
  (get-buffer-window (anything-buffer-get) 'visible))

(defun anything-action-window ()
  "<span class="quote">Window of `anything-action-buffer'.</span>"
  (get-buffer-window anything-action-buffer 'visible))

(defmacro with-anything-window (&rest body)
  `(let ((--tmpfunc-- (lambda () ,@body)))
     (if anything-test-mode
         (with-current-buffer (anything-buffer-get)
           (funcall --tmpfunc--))
       (with-selected-window (anything-window)
         (funcall --tmpfunc--)))))
(put 'with-anything-window 'lisp-indent-function 0)

(defmacro with-anything-restore-variables(&rest body)
  "<span class="quote">Restore variables specified by `anything-restored-variables' after executing BODY .</span>"
  `(let ((--orig-vars (mapcar (lambda (v) (cons v (symbol-value v))) anything-restored-variables)))
     (unwind-protect (progn ,@body)
       (loop for (var . value) in --orig-vars
             do (set var value)))))
(put 'with-anything-restore-variables 'lisp-indent-function 0)

(defun* anything-attr (attribute-name &optional (src (anything-get-current-source)))
  "<span class="quote">Get the value of ATTRIBUTE-NAME of SRC (source).
if SRC is omitted, use current source.
It is useful to write your sources.</span>"
  (anything-aif (assq attribute-name src)
      (cdr it)))

(defun* anything-attr-defined (attribute-name &optional (src (anything-get-current-source)))
  "<span class="quote">Return non-nil if ATTRIBUTE-NAME of SRC (source)  is defined.
if SRC is omitted, use current source.
It is useful to write your sources.</span>"
  (and (assq attribute-name src) t))

(defun* anything-attrset (attribute-name value &optional (src (anything-get-current-source)))
  "<span class="quote">Set the value of ATTRIBUTE-NAME of SRC (source) to VALUE.
if SRC is omitted, use current source.
It is useful to write your sources.</span>"
  (anything-aif (assq attribute-name src)
      (setcdr it value)
    (setcdr src (cons (cons attribute-name value) (cdr src))))
  value)

<span class="linecomment">;; anything-set-source-filter</span>
<span class="linecomment">;;</span>
<span class="linecomment">;;   This function sets a filter for anything sources and it may be</span>
<span class="linecomment">;;   called while anything is running. It can be used to toggle</span>
<span class="linecomment">;;   displaying of sources dinamically. For example, additional keys</span>
<span class="linecomment">;;   can be bound into `anything-map' to display only the file-related</span>
<span class="linecomment">;;   results if there are too many matches from other sources and</span>
<span class="linecomment">;;   you're after files only:</span>
<span class="linecomment">;;</span>
<span class="linecomment">;;   Shift+F shows only file results from some sources:</span>
<span class="linecomment">;;</span>
<span class="linecomment">;;     (define-key anything-map "F" 'anything-my-show-files-only)</span>
<span class="linecomment">;;     </span>
<span class="linecomment">;;     (defun anything-my-show-files-only ()</span>
<span class="linecomment">;;       (interactive)</span>
<span class="linecomment">;;       (anything-set-source-filter '("File Name History"</span>
<span class="linecomment">;;                                     "Files from Current Directory")))</span>
<span class="linecomment">;;</span>
<span class="linecomment">;;   Shift+A shows all results:</span>
<span class="linecomment">;;</span>
<span class="linecomment">;;     (define-key anything-map "A" 'anything-my-show-all)</span>
<span class="linecomment">;;     </span>
<span class="linecomment">;;     (defun anything-my-show-all ()</span>
<span class="linecomment">;;       (interactive)</span>
<span class="linecomment">;;       (anything-set-source-filter nil))</span>
<span class="linecomment">;;  </span>
<span class="linecomment">;;  </span>
<span class="linecomment">;;   Note that you have to prefix the functions with anything- prefix,</span>
<span class="linecomment">;;   otherwise they won't be bound when Anything is used under</span>
<span class="linecomment">;;   Iswitchb. The -my- part is added to avoid collisions with</span>
<span class="linecomment">;;   existing Anything function names.</span>
<span class="linecomment">;;  </span>
(defun anything-set-source-filter (sources)
  "<span class="quote">Sets the value of `anything-source-filter' and updates the list of results.</span>"
  (setq anything-source-filter sources)
  (anything-update))

(defun anything-set-sources (sources &optional no-init no-update)
  "<span class="quote">Set `anything-sources' during `anything' invocation.
If NO-INIT is non-nil, skip executing init functions of SOURCES.
If NO-UPDATE is non-nil, skip executing `anything-update'.</span>"
  (setq anything-compiled-sources nil
        anything-sources sources)
  (unless no-init (anything-funcall-foreach 'init))
  (unless no-update (anything-update)))

(defvar anything-compile-source-functions
  '(anything-compile-source--type anything-compile-source--dummy anything-compile-source--candidates-in-buffer)
  "<span class="quote">Functions to compile elements of `anything-sources' (plug-in).</span>")

(defun anything-get-sources ()
  "<span class="quote">Return compiled `anything-sources', which is memoized.

Attributes:

- type
  `anything-type-attributes' are merged in.
- candidates-buffer
  candidates, volatile and match attrubute are created.
</span>"
  (cond
   <span class="linecomment">;; action</span>
   ((anything-action-window)
    anything-sources)
   <span class="linecomment">;; memoized</span>
   (anything-compiled-sources)
   <span class="linecomment">;; first time</span>
   (t
    (setq anything-compiled-sources
          (anything-compile-sources anything-sources anything-compile-source-functions)))))

(defun* anything-get-selection (&optional (buffer nil buffer-s) (force-display-part))
  "<span class="quote">Return the currently selected item or nil.
if BUFFER is nil or unspecified, use anything-buffer as default value.
If FORCE-DISPLAY-PART is non-nil, return the display string.</span>"
  (setq buffer (if (and buffer buffer-s) buffer anything-buffer))
  (unless (zerop (buffer-size (get-buffer buffer)))
    (with-current-buffer buffer
      (let ((selection
             (or (and (not force-display-part)
                      (get-text-property (overlay-start
                                          anything-selection-overlay)
                                         'anything-realvalue))
                 (buffer-substring-no-properties
                  (overlay-start anything-selection-overlay)
                  (1- (overlay-end anything-selection-overlay))))))
        (unless (equal selection "<span class="quote"></span>")
          selection)))))

(defun anything-get-action ()
  "<span class="quote">Return the associated action for the selected candidate.</span>"
  (unless (zerop (buffer-size (get-buffer (anything-buffer-get))))
    (let* ((source (anything-get-current-source))
           (actions (assoc-default 'action source)))

      (anything-aif (assoc-default 'action-transformer source)
          <span class="linecomment">;; (funcall it actions (anything-get-selection))</span>
          (anything-composed-funcall-with-source source it actions (anything-get-selection))
        actions))))

(defun anything-get-current-source ()
  "<span class="quote">Return the source for the current selection / in init/candidates/action/candidate-transformer/filtered-candidate-transformer function.</span>"
  (declare (special source))
  <span class="linecomment">;; The name `anything-get-current-source' should be used in init function etc.</span>
  (if (and (boundp 'anything-source-name) (stringp anything-source-name))
      source
    (with-current-buffer (anything-buffer-get)
      <span class="linecomment">;; This goto-char shouldn't be necessary, but point is moved to</span>
      <span class="linecomment">;; point-min somewhere else which shouldn't happen.</span>
      (goto-char (overlay-start anything-selection-overlay))
      (let* ((header-pos (anything-get-previous-header-pos))
             (source-name
              (save-excursion
                (assert header-pos)
                (goto-char header-pos)
                (buffer-substring-no-properties
                 (line-beginning-position) (line-end-position)))))
        (some (lambda (source)
                (if (equal (assoc-default 'name source)
                           source-name)
                    source))
              (anything-get-sources))))))

(defun anything-buffer-is-modified (buffer)
  "<span class="quote">Return non-nil when BUFFER is modified since `anything' was invoked.</span>"
  (let* ((b (get-buffer buffer))
         (key (concat (buffer-name b)
                     "<span class="quote">/</span>"
                     (anything-attr 'name)))
         (source-tick (or (gethash key anything-tick-hash) 0))
         (buffer-tick (buffer-chars-modified-tick b)))
    (prog1 (/= source-tick buffer-tick)
      (puthash key buffer-tick anything-tick-hash))))
(defun anything-current-buffer-is-modified ()
  "<span class="quote">Return non-nil when `anything-current-buffer' is modified since `anything' was invoked.</span>"
  (anything-buffer-is-modified anything-current-buffer))

(defvar anything-quit nil)
(defun anything-run-after-quit (function &rest args)
  "<span class="quote">Perform an action after quitting `anything'.
The action is to call FUNCTION with arguments ARGS.</span>"
  (setq anything-quit t)
  (apply 'run-with-idle-timer 0 nil function args)
  (anything-exit-minibuffer))

(defun define-anything-type-attribute (type definition &optional doc)
  "<span class="quote">Register type attribute of TYPE as DEFINITION with DOC.
DOC is displayed in `anything-type-attributes' docstring.

Use this function is better than setting `anything-type-attributes' directly.</span>"
  (anything-add-type-attribute type definition)
  (and doc (anything-document-type-attribute type doc))
  nil)

(defvar anything-additional-attributes nil)
(defun anything-document-attribute (attribute short-doc &optional long-doc)
  "<span class="quote">Register ATTRIBUTE documentation introduced by plug-in.
SHORT-DOC is displayed beside attribute name.
LONG-DOC is displayed below attribute name and short documentation.</span>"
  (if long-doc
      (setq short-doc (concat "<span class="quote">(</span>" short-doc "<span class="quote">)</span>"))
    (setq long-doc short-doc
          short-doc "<span class="quote"></span>"))
  (add-to-list 'anything-additional-attributes attribute t)
  (put attribute 'anything-attrdoc
       (concat "<span class="quote">- </span>" (symbol-name attribute) "<span class="quote"> </span>" short-doc "<span class="quote">\n\n</span>" long-doc "<span class="quote">\n</span>")))
(put 'anything-document-attribute 'lisp-indent-function 2)

<span class="linecomment">;; (@* "Core: tools")</span>
(defun anything-current-frame/window-configuration ()
  (funcall (cdr anything-save-configuration-functions)))

(defun anything-set-frame/window-configuration (conf)
  (funcall (car anything-save-configuration-functions) conf))

(defun anything-funcall-with-source (source func &rest args)
  (let ((anything-source-name (assoc-default 'name source)))
    (apply func args)))

(defun anything-funcall-foreach (sym)
  "<span class="quote">Call the sym function(s) for each source if any.</span>"
  (dolist (source (anything-get-sources))
    (when (symbolp source)
      (setq source (symbol-value source)))
    (anything-aif (assoc-default sym source)
        (dolist (func (if (functionp it) (list it) it))
          (anything-funcall-with-source source func)))))

(defun anything-normalize-sources (sources)
  (cond ((and sources (symbolp sources)) (list sources))
        (sources)
        (t anything-sources)))  

(defun anything-approximate-candidate-number ()
  "<span class="quote">Approximate Number of candidates.
It is used to check if candidate number is 0 or 1.</span>"
  (with-current-buffer anything-buffer
    (1- (line-number-at-pos (1- (point-max))))))

(defmacro with-anything-quittable (&rest body)
  `(let (inhibit-quit)
     (condition-case v
         (progn ,@body)
       (quit (setq anything-quit t)
             (exit-minibuffer)
             (keyboard-quit)))))
(put 'with-anything-quittable 'lisp-indent-function 0)

(defun anything-compose (arg-lst func-lst)
  "<span class="quote">Call each function in FUNC-LST with the arguments specified in ARG-LST.
The result of each function will be the new `car' of ARG-LST.

This function allows easy sequencing of transformer functions.</span>"
  (dolist (func func-lst)
    (setcar arg-lst (apply func arg-lst)))
  (car arg-lst))

(defun anything-composed-funcall-with-source (source funcs &rest args)
  (if (functionp funcs)
      (apply 'anything-funcall-with-source source funcs args)
    (apply 'anything-funcall-with-source
           source (lambda (&rest args) (anything-compose args funcs)) args)))

<span class="linecomment">;; (@* "Core: entry point")</span>
(defun anything (&optional any-sources any-input any-prompt any-resume any-preselect any-buffer)
  "<span class="quote">Select anything. In Lisp program, some optional arguments can be used.

Note that all the optional arguments are prefixed because of
dynamic scope problem, IOW argument variables may eat
already-bound variables. Yuck!

- ANY-SOURCES

  Temporary value of `anything-sources'. ANY-SOURCES accepts a
  symbol, interpreted as a variable of an anything source.

- ANY-INPUT

  Temporary value of `anything-pattern', ie. initial input of minibuffer.

- ANY-PROMPT

  Prompt other than \"pattern: \".

- ANY-RESUME

  Resurrect previously instance of `anything'. Skip the initialization.

- ANY-PRESELECT

  Initially selected candidate. Specified by exact candidate or a regexp.
  Note that it is not working with delayed sources.

- ANY-BUFFER

  `anything-buffer' instead of *anything*.
</span>"
  <span class="linecomment">;; TODO more document</span>
  (interactive)
  (condition-case v
      (with-anything-restore-variables
        (let ((frameconfig (anything-current-frame/window-configuration))
              <span class="linecomment">;; It is needed because `anything-source-name' is non-nil</span>
              <span class="linecomment">;; when `anything' is invoked by action. Awful global scope.</span>
              anything-source-name anything-in-persistent-action
              anything-quit anything-follow-mode
              (case-fold-search t)
              (anything-buffer (or any-buffer anything-buffer))
              (anything-sources (anything-normalize-sources any-sources)))
         
          (add-hook 'post-command-hook 'anything-check-minibuffer-input)
          (add-hook 'minibuffer-setup-hook 'anything-print-error-messages)
          (setq anything-current-position (cons (point) (window-start)))
          (if any-resume
              (anything-initialize-overlays (anything-buffer-get))
            (anything-initialize))
          (setq anything-last-buffer anything-buffer)
          (when any-input (setq anything-input any-input anything-pattern any-input))
          (anything-display-buffer anything-buffer)
          (unwind-protect
              (progn
                (if any-resume (anything-mark-current-line) (anything-update))
                
                (select-frame-set-input-focus (window-frame (minibuffer-window)))
                (anything-preselect any-preselect)
                (let ((ncandidate (anything-approximate-candidate-number))
                      (minibuffer-local-map anything-map))
                  (cond ((and anything-execute-action-at-once-if-one
                              (= ncandidate 1))
                         (ignore))
                        ((and anything-quit-if-no-candidate (= ncandidate 0))
                         (setq anything-quit t)
                         (and (functionp anything-quit-if-no-candidate)
                              (funcall anything-quit-if-no-candidate)))
                        (t
                         (read-string (or any-prompt "<span class="quote">pattern: </span>")
                                      (if any-resume anything-pattern any-input))))))
            (anything-cleanup)
            (remove-hook 'minibuffer-setup-hook 'anything-print-error-messages)
            (remove-hook 'post-command-hook 'anything-check-minibuffer-input)
            (anything-set-frame/window-configuration frameconfig))
          (unless anything-quit
            (unwind-protect
                (anything-execute-selection-action)
              (anything-aif (get-buffer anything-action-buffer)
                  (kill-buffer it))
              (run-hooks 'anything-after-action-hook)))))
    (quit
     (setq minibuffer-history (cons anything-input minibuffer-history))
     (goto-char (car anything-current-position))
     (set-window-start (selected-window) (cdr anything-current-position))
     nil)))

(defun* anything-resume (&optional (any-buffer anything-last-buffer))
  "<span class="quote">Resurrect previously invoked `anything'.</span>"
  (interactive)
  (when current-prefix-arg
    (setq any-buffer
          (completing-read
           "<span class="quote">Resume anything buffer: </span>"
           (delq nil
                 (mapcar (lambda (b)
                           (when (buffer-local-value 'anything-last-sources-local b)
                             (list (buffer-name b)))) (buffer-list)))
           nil t nil nil anything-buffer)))
  (setq anything-compiled-sources nil)
  (anything
   (or (buffer-local-value 'anything-last-sources-local (get-buffer any-buffer))
       anything-last-sources anything-sources)
   nil nil t nil any-buffer))

(defun anything-at-point (&optional any-sources any-input any-prompt any-resume any-preselect any-buffer)
  "<span class="quote">Same as `anything' except when C-u is pressed, the initial input is the symbol at point.</span>"
  (interactive)
  (anything any-sources
            (if current-prefix-arg
                (concat "<span class="quote">\\b</span>" (thing-at-point 'symbol) "<span class="quote">\\b</span>"
                        (if (featurep 'anything-match-plugin) "<span class="quote"> </span>" "<span class="quote"></span>"))
              any-input)
            any-prompt any-resume any-preselect any-buffer))

(defun anything-other-buffer (any-sources any-buffer)
  "<span class="quote">Simplified interface of `anything' with other `anything-buffer'</span>"
  (anything any-sources nil nil nil nil any-buffer))

<span class="linecomment">;; (@* "Core: Display *anything* buffer")</span>
(defun anything-display-buffer (buf)
  "<span class="quote">Display *anything* buffer.</span>"
  (funcall anything-display-function buf))

(defun anything-default-display-buffer (buf)
  (funcall (if anything-samewindow 'switch-to-buffer 'pop-to-buffer) buf))

<span class="linecomment">;; (@* "Core: initialize")</span>
(defun anything-initialize ()
  "<span class="quote">Initialize anything settings and set up the anything buffer.</span>"
  (run-hooks 'anything-before-initialize-hook)
  (setq anything-current-buffer (current-buffer))
  (setq anything-buffer-file-name buffer-file-name)
  (setq anything-issued-errors nil)
  (setq anything-compiled-sources nil)
  (setq anything-saved-current-source nil)
  <span class="linecomment">;; Call the init function for sources where appropriate</span>
  (anything-funcall-foreach 'init)

  (setq anything-pattern "<span class="quote"></span>")
  (setq anything-input "<span class="quote"></span>")
  (setq anything-candidate-cache nil)
  (setq anything-last-sources anything-sources)

  (anything-create-anything-buffer)
  (run-hooks 'anything-after-initialize-hook))

(defun anything-create-anything-buffer (&optional test-mode)
  "<span class="quote">Create newly created `anything-buffer'.
If TEST-MODE is non-nil, clear `anything-candidate-cache'.</span>"
  (when test-mode
    (setq anything-candidate-cache nil))
  (with-current-buffer (get-buffer-create anything-buffer)
    (buffer-disable-undo)
    (erase-buffer)
    (set (make-local-variable  'inhibit-read-only) t)
    (set (make-local-variable 'anything-last-sources-local) anything-sources)
    (setq cursor-type nil)
    (setq mode-name "<span class="quote">Anything</span>"))
  (anything-initialize-overlays anything-buffer)
  (get-buffer anything-buffer))

(defun anything-initialize-overlays (buffer)
  (if anything-selection-overlay
      <span class="linecomment">;; make sure the overlay belongs to the anything buffer if</span>
      <span class="linecomment">;; it's newly created</span>
      (move-overlay anything-selection-overlay (point-min) (point-min)
                    (get-buffer buffer))

    (setq anything-selection-overlay 
          (make-overlay (point-min) (point-min) (get-buffer buffer)))
    (overlay-put anything-selection-overlay 'face anything-selection-face))

  (if anything-enable-digit-shortcuts
      (unless anything-digit-overlays
        (dotimes (i 9)
          (push (make-overlay (point-min) (point-min)
                              (get-buffer buffer))
                anything-digit-overlays)
          (overlay-put (car anything-digit-overlays)
                       'before-string (concat (int-to-string (1+ i)) "<span class="quote"> - </span>")))
        (setq anything-digit-overlays (nreverse anything-digit-overlays)))

    (when anything-digit-overlays
      (dolist (overlay anything-digit-overlays)
        (delete-overlay overlay))
      (setq anything-digit-overlays nil))))

<span class="linecomment">;; (@* "Core: clean up")</span>
(defun anything-cleanup ()
  "<span class="quote">Clean up the mess.</span>"
  (with-current-buffer anything-buffer
    (setq cursor-type t))
  (bury-buffer anything-buffer)
  (anything-funcall-foreach 'cleanup)
  (if anything-check-minibuffer-input-timer
      (cancel-timer anything-check-minibuffer-input-timer))
  (anything-kill-async-processes)
  (run-hooks 'anything-cleanup-hook))

<span class="linecomment">;; (@* "Core: input handling")</span>
(defun anything-check-minibuffer-input ()
  "<span class="quote">Extract input string from the minibuffer and check if it needs
to be handled.</span>"
  (if (or (not anything-input-idle-delay) (anything-action-window))
      (anything-check-minibuffer-input-1)
    (if anything-check-minibuffer-input-timer
        (cancel-timer anything-check-minibuffer-input-timer))
    (setq anything-check-minibuffer-input-timer
          (run-with-idle-timer anything-input-idle-delay nil
                               'anything-check-minibuffer-input-1))))

(defun anything-check-minibuffer-input-1 ()
  (with-anything-quittable
    (with-selected-window (minibuffer-window)
      (anything-check-new-input (minibuffer-contents)))))

(defun anything-check-new-input (input)
  "<span class="quote">Check input string and update the anything buffer if
necessary.</span>"
  (unless (equal input anything-pattern)
    (setq anything-pattern input)
    (unless (anything-action-window)
      (setq anything-input anything-pattern))
    (anything-update)))

<span class="linecomment">;; (@* "Core: source compiler")</span>
(defvar anything-compile-source-functions-default anything-compile-source-functions
  "<span class="quote">Plug-ins this file provides.</span>")
(defun anything-compile-sources (sources funcs)
  "<span class="quote">Compile sources (`anything-sources') with funcs (`anything-compile-source-functions').
Anything plug-ins are realized by this function.</span>"
  (mapcar
   (lambda (source)
     (loop with source = (if (listp source) source (symbol-value source))
           for f in funcs
           do (setq source (funcall f source))
           finally (return source)))
   sources))  

<span class="linecomment">;; (@* "Core: plug-in attribute documentation hack")</span>

<span class="linecomment">;; `anything-document-attribute' is public API.</span>
(defadvice documentation-property (after anything-document-attribute activate)
  "<span class="quote">Hack to display plug-in attributes' documentation as `anything-sources' docstring.</span>"
  (when (eq symbol 'anything-sources)
    (setq ad-return-value
          (concat ad-return-value "<span class="quote">++++ Additional attributes by plug-ins ++++\n</span>"
                  (mapconcat (lambda (sym) (get sym 'anything-attrdoc))
                             anything-additional-attributes
                             "<span class="quote">\n</span>")))))
<span class="linecomment">;; (describe-variable 'anything-sources)</span>
<span class="linecomment">;; (documentation-property 'anything-sources 'variable-documentation)</span>
<span class="linecomment">;; (progn (ad-disable-advice 'documentation-property 'after 'anything-document-attribute) (ad-update 'documentation-property)) </span>

<span class="linecomment">;; (@* "Core: all candidates")</span>
(defun anything-get-candidates (source)
  "<span class="quote">Retrieve and return the list of candidates from
SOURCE.</span>"
  (let* ((candidate-source (assoc-default 'candidates source))
         (candidates
          (if (functionp candidate-source)
                (anything-funcall-with-source source candidate-source)
            (if (listp candidate-source)
                candidate-source
              (if (and (symbolp candidate-source)
                       (boundp candidate-source))
                  (symbol-value candidate-source)
                (error (concat "<span class="quote">Candidates must either be a function, </span>"
                               "<span class="quote"> a variable or a list: %s</span>")
                       candidate-source))))))
    (if (processp candidates)
        candidates
      (anything-transform-candidates candidates source))))
         

(defun anything-transform-candidates (candidates source)
  "<span class="quote">Transform CANDIDATES according to candidate transformers.</span>"
  (anything-aif (assoc-default 'candidate-transformer source)
      (anything-composed-funcall-with-source source it candidates)
    candidates))


(defun anything-get-cached-candidates (source)
  "<span class="quote">Return the cached value of candidates for SOURCE.
Cache the candidates if there is not yet a cached value.</span>"
  (let* ((name (assoc-default 'name source))
         (candidate-cache (assoc name anything-candidate-cache))
         candidates)

    (if candidate-cache
        (setq candidates (cdr candidate-cache))

      (setq candidates (anything-get-candidates source))

      (if (processp candidates)
          (progn
            (push (cons candidates
                        (append source 
                                (list (cons 'item-count 0)
                                      (cons 'incomplete-line "<span class="quote"></span>"))))
                  anything-async-processes)
            (set-process-filter candidates 'anything-output-filter)
            (setq candidates nil))

        (unless (assoc 'volatile source)
          (setq candidate-cache (cons name candidates))
          (push candidate-cache anything-candidate-cache))))

    candidates))

<span class="linecomment">;; (@* "Core: narrowing candidates")</span>
(defun anything-candidate-number-limit (source)
  "<span class="quote">`anything-candidate-number-limit' variable may be overridden by SOURCE.</span>"
  (or (assoc-default 'candidate-number-limit source)
      anything-candidate-number-limit
      99999999))

(defun anything-compute-matches (source)
  "<span class="quote">Compute matches from SOURCE according to its settings.</span>"
  (let ((doit (lambda ()
                (let ((functions (assoc-default 'match source))
                      (limit (anything-candidate-number-limit source))
                      matches)
                  (cond ((or (equal anything-pattern "<span class="quote"></span>") (equal functions '(identity)))
                         (setq matches (anything-get-cached-candidates source))
                         (if (&gt; (length matches) limit)
                             (setq matches 
                                   (subseq matches 0 limit))))
                        (t
                         (condition-case nil
                             (let ((item-count 0)
                                   (cands (anything-get-cached-candidates source))
                                   exit)

                               (unless functions
                                 (setq functions
                                       (list (lambda (candidate)
                                               (string-match anything-pattern candidate)))))

                               (clrhash anything-match-hash)
                               (dolist (function functions)
                                 (let (newmatches c cc)
                                   (dolist (candidate cands)
                                     (when (and (not (gethash candidate anything-match-hash))
                                                (setq c (if (listp candidate)
                                                                     (car candidate)
                                                                   candidate))
                                                (setq cc (cond ((stringp c) c)
                                                               ((symbolp c) (symbol-name c))))
                                                (funcall function cc))
                                       (puthash candidate t anything-match-hash)
                                       (push candidate newmatches)

                                       (when limit
                                         (incf item-count)
                                         (when (= item-count limit)
                                           (setq exit t)
                                           (return)))))

                                   (setq matches (append matches (reverse newmatches)))

                                   (if exit
                                       (return)))))

                           (invalid-regexp (setq matches nil)))))

                  (anything-aif (assoc-default 'filtered-candidate-transformer source)
                      (setq matches
                            (anything-composed-funcall-with-source source it matches source)))
                  matches))))
    (if debug-on-error
        (funcall doit)
      (condition-case v
          (funcall doit)
        (error (anything-log-error
                "<span class="quote">anything-compute-matches: error when processing source: %s</span>"
                (assoc-default 'name source))
               nil)))))

<span class="linecomment">;; (anything '(((name . "error")(candidates . (lambda () (hage))) (action . identity))))</span>

(defun anything-process-source (source)
  "<span class="quote">Display matches from SOURCE according to its settings.</span>"
  (let ((matches (anything-compute-matches source)))
    (when matches
      (when anything-test-mode
          (setq anything-test-candidate-list
                `(,@anything-test-candidate-list
                  (,(assoc-default 'name source)
                   ,matches))))
      (let ((multiline (assoc 'multiline source))
            (real-to-display (assoc-default 'real-to-display source))
            (start (point))
            separate)
        (anything-insert-header-from-source source)
        (dolist (match matches)
          (when (and anything-enable-digit-shortcuts
                     (not (eq anything-digit-shortcut-count 9)))
            (move-overlay (nth anything-digit-shortcut-count
                               anything-digit-overlays)
                          (line-beginning-position)
                          (line-beginning-position))
            (incf anything-digit-shortcut-count))

          (if (and multiline separate)
              (anything-insert-candidate-separator)
            (setq separate t))
          (anything-insert-match match 'insert real-to-display))
        
        (if multiline
            (put-text-property start (point) 'anything-multiline t))))))

(defun anything-process-delayed-sources (delayed-sources)
  "<span class="quote">Process delayed sources if the user is idle for
`anything-idle-delay' seconds.</span>"
  (with-anything-quittable
    (if (sit-for (if anything-input-idle-delay
                     (max 0 (- anything-idle-delay anything-input-idle-delay))
                   anything-idle-delay))
        (with-current-buffer anything-buffer        
          (save-excursion
            (goto-char (point-max))
            (dolist (source delayed-sources)
              (anything-process-source source))

            (when (and (not (equal (buffer-size) 0))
                       <span class="linecomment">;; no selection yet</span>
                       (= (overlay-start anything-selection-overlay)
                          (overlay-end anything-selection-overlay)))
              (goto-char (point-min))
              (anything-next-line)))
          (save-excursion
            (goto-char (point-min))
            (run-hooks 'anything-update-hook))
          (anything-maybe-fit-frame)))))

<span class="linecomment">;; (@* "Core: *anything* buffer contents")</span>
(defun anything-update ()
  "<span class="quote">Update the list of matches in the anything buffer according to
the current pattern.</span>"
  (setq anything-digit-shortcut-count 0)
  (anything-kill-async-processes)
  (with-current-buffer (anything-buffer-get)
    (erase-buffer)

    (if anything-enable-digit-shortcuts
        (dolist (overlay anything-digit-overlays)
          (delete-overlay overlay)))

    (let (delayed-sources)
      (dolist (source (anything-get-sources))
        (when (and (or (not anything-source-filter)
                       (member (assoc-default 'name source) anything-source-filter))
                   (&gt;= (length anything-pattern)
                       (anything-aif (assoc 'requires-pattern source)
                           (or (cdr it) 1)
                         0)))
          (if (or (assoc 'delayed source)
                  (and anything-quick-update
                       (&lt; (window-height (get-buffer-window (current-buffer)))
                          (line-number-at-pos (point-max)))))
              (push source delayed-sources)
            (anything-process-source source))))

      (goto-char (point-min))
      (save-excursion (run-hooks 'anything-update-hook))
      (anything-next-line)
      (setq delayed-sources (nreverse delayed-sources))
      (if anything-test-mode
          (dolist (source delayed-sources)
            (anything-process-source source))
        (anything-maybe-fit-frame)
        (run-with-idle-timer (if (featurep 'xemacs)
                                 0.1
                               0)
                             nil
                             'anything-process-delayed-sources
                             delayed-sources)))))

(defun anything-insert-match (match insert-function &optional real-to-display)
  "<span class="quote">Insert MATCH into the anything buffer. If MATCH is a list then
insert the string inteneded to appear on the display and store
the real value in a text property.</span>"
  (let ((start (line-beginning-position (point)))
        (string (if (listp match) (car match) match))
        (realvalue (if (listp match) (cdr match) match)))
    (and (functionp real-to-display)
         (setq string (funcall real-to-display realvalue)))
    (when (symbolp string) (setq string (symbol-name string)))
    (when (stringp string)                    <span class="linecomment">; real-to-display may return nil</span>
      (funcall insert-function string)
      <span class="linecomment">;; Some sources with candidates-in-buffer have already added</span>
      <span class="linecomment">;; 'anything-realvalue property when creating candidate buffer.</span>
      (unless (get-text-property start 'anything-realvalue)
        (put-text-property start (line-end-position)
                           'anything-realvalue realvalue))
      (funcall insert-function "<span class="quote">\n</span>"))))

(defun anything-insert-header-from-source (source)
  (let ((name (assoc-default 'name source)))
    (anything-insert-header name
                            (anything-aif (assoc-default 'header-name source)
                                (anything-funcall-with-source source it name)))))

(defun anything-insert-header (name &optional display-string)
  "<span class="quote">Insert header of source NAME into the anything buffer.</span>"
  (unless (bobp)
    (let ((start (point)))
      (insert "<span class="quote">\n</span>")
      (put-text-property start (point) 'anything-header-separator t)))

  (let ((start (point)))
    (insert name)
    (put-text-property (line-beginning-position)
                       (line-end-position) 'anything-header t)
    (when display-string
      (overlay-put (make-overlay (line-beginning-position) (line-end-position))
                   'display display-string))
    (insert "<span class="quote">\n</span>")
    (put-text-property start (point) 'face anything-header-face)))


(defun anything-insert-candidate-separator ()
  "<span class="quote">Insert separator of candidates into the anything buffer.</span>"
  (insert anything-candidate-separator)
  (put-text-property (line-beginning-position)
                     (line-end-position) 'anything-candidate-separator t)
  (insert "<span class="quote">\n</span>"))




<span class="linecomment">;; (@* "Core: async process")</span>
(defun anything-output-filter (process string)
  "<span class="quote">Process output from PROCESS.</span>"
  (let* ((process-assoc (assoc process anything-async-processes))
         (process-info (cdr process-assoc))
         (insertion-marker (assoc-default 'insertion-marker process-info))
         (incomplete-line-info (assoc 'incomplete-line process-info))
         (item-count-info (assoc 'item-count process-info))
         (real-to-display (assoc-default 'real-to-display process-info)))

    (with-current-buffer anything-buffer
      (save-excursion
        (if insertion-marker
            (goto-char insertion-marker)
        
          (goto-char (point-max))
          (anything-insert-header-from-source process-info)
          (setcdr process-assoc
                  (append process-info `((insertion-marker . ,(point-marker))))))

        (let ((lines (split-string string "<span class="quote">\n</span>"))
              candidates)
          (while lines
            (if (not (cdr lines))
                <span class="linecomment">;; store last incomplete line until new output arrives</span>
                (setcdr incomplete-line-info (car lines))

              (if (cdr incomplete-line-info)
                  (progn
                    (push (concat (cdr incomplete-line-info) (car lines))
                          candidates)
                    (setcdr incomplete-line-info nil))

              (push (car lines) candidates)))
                  
            (pop lines))

          (setq candidates (reverse candidates))
          (dolist (candidate (anything-transform-candidates candidates process-info))
            (anything-insert-match candidate 'insert-before-markers real-to-display)
            (incf (cdr item-count-info))
            (when (&gt;= (cdr item-count-info) anything-candidate-number-limit)
              (anything-kill-async-process process)
              (return)))))

      (anything-maybe-fit-frame)

      (run-hooks 'anything-update-hook)

      (if (bobp)
          (anything-next-line)

        (save-selected-window
          (select-window (get-buffer-window anything-buffer 'visible))
          (anything-mark-current-line))))))


(defun anything-kill-async-processes ()
  "<span class="quote">Kill all known asynchronous processes according to
`anything-async-processes'.</span>"
    "<span class="quote">Kill locate process.</span>"
    (dolist (process-info anything-async-processes)
      (anything-kill-async-process (car process-info)))
    (setq anything-async-processes nil))


(defun anything-kill-async-process (process)
  "<span class="quote">Kill PROCESS and detach the associated functions.</span>"
  (set-process-filter process nil)
  (delete-process process))
  

<span class="linecomment">;; (@* "Core: action")</span>
(defun anything-execute-selection-action (&optional selection action clear-saved-action display-to-real)
  "<span class="quote">If a candidate was selected then perform the associated
action.</span>"
  (setq selection (or selection (anything-get-selection)))
  (setq action (or action
                   anything-saved-action
                   (if (get-buffer anything-action-buffer)
                       (anything-get-selection anything-action-buffer)
                     (anything-get-action))))
  (let ((source (or anything-saved-current-source (anything-get-current-source))))
    (if (and (not selection) (assoc 'accept-empty source))
        (setq selection "<span class="quote"></span>"))
    (setq display-to-real
          (or display-to-real (assoc-default 'display-to-real source)
              #'identity))
    (if (and (listp action)
             (not (functionp action)))  <span class="linecomment">; lambda</span>
        <span class="linecomment">;;select the default action</span>
        (setq action (cdar action)))
    (unless clear-saved-action (setq anything-saved-action nil))
    (if (and selection action)
        (anything-funcall-with-source
         source  action
         (anything-funcall-with-source source display-to-real selection)))))

(defun anything-select-action ()
  "<span class="quote">Select an action for the currently selected candidate.
If action buffer is selected, back to the anything buffer.</span>"
  (interactive)
  (cond ((get-buffer-window anything-action-buffer 'visible)
         (set-window-buffer (get-buffer-window anything-action-buffer) anything-buffer)
         (kill-buffer anything-action-buffer))
        (t
         (setq anything-saved-selection (anything-get-selection))
         (unless anything-saved-selection
           (error "<span class="quote">Nothing is selected.</span>"))
         (setq anything-saved-current-source (anything-get-current-source))
         (let ((actions (anything-get-action)))
           (if (functionp actions)
               (message "<span class="quote">Sole action: %s</span>" actions)
             (with-current-buffer (get-buffer-create anything-action-buffer)
               (erase-buffer)
               (buffer-disable-undo)
               (set-window-buffer (get-buffer-window anything-buffer) anything-action-buffer)
               (set (make-local-variable 'anything-sources)
                    `(((name . "<span class="quote">Actions</span>")
                       (volatile)
                       (candidates . ,actions)
                       <span class="linecomment">;; Override `anything-candidate-number-limit'</span>
                       (candidate-number-limit . 9999))))
               (set (make-local-variable 'anything-source-filter) nil)
               (set (make-local-variable 'anything-selection-overlay) nil)
               (set (make-local-variable 'anything-digit-overlays) nil)
               (anything-initialize-overlays anything-action-buffer))
             (with-selected-window (minibuffer-window)
               (delete-minibuffer-contents))
             (setq anything-pattern 'dummy) <span class="linecomment">; so that it differs from the</span>
                                        <span class="linecomment">; previous one</span>
           
             (anything-check-minibuffer-input))))))

<span class="linecomment">;; (@* "Core: selection")</span>
(defun anything-previous-line ()
  "<span class="quote">Move selection to the previous line.</span>"
  (interactive)
  (anything-move-selection 'line 'previous))

(defun anything-next-line ()
  "<span class="quote">Move selection to the next line.</span>"
  (interactive)
  (anything-move-selection 'line 'next))

(defun anything-previous-page ()
  "<span class="quote">Move selection back with a pageful.</span>"
  (interactive)
  (anything-move-selection 'page 'previous))

(defun anything-next-page ()
  "<span class="quote">Move selection forward with a pageful.</span>"
  (interactive)
  (anything-move-selection 'page 'next))


(defun anything-previous-source ()
  "<span class="quote">Move selection to the previous source.</span>"
  (interactive)
  (anything-move-selection 'source 'previous))


(defun anything-next-source ()
  "<span class="quote">Move selection to the next source.</span>"
  (interactive)
  (anything-move-selection 'source 'next))


(defun anything-move-selection (unit direction)
  "<span class="quote">Move the selection marker to a new position determined by
UNIT and DIRECTION.</span>"
  (unless (or (zerop (buffer-size (get-buffer (anything-buffer-get))))
              (not (anything-window)))
    (with-anything-window
      (case unit
        (line (case direction
                (next (if (not (anything-pos-multiline-p))
                          (forward-line 1)
                        (let ((header-pos (anything-get-next-header-pos))
                              (candidate-pos (anything-get-next-candidate-separator-pos)))
                          (if (and candidate-pos
                                   (or (null header-pos)
                                       (&lt; candidate-pos header-pos)))
                              (goto-char candidate-pos)
                            (if header-pos
                                (goto-char header-pos)))
                          (if candidate-pos
                              (forward-line 1)))))
                
                (previous (progn
                            (forward-line -1)
                            (when (anything-pos-multiline-p)
                              (if (or (anything-pos-header-line-p)
                                      (anything-pos-candidate-separator-p))
                                  (forward-line -1)
                                (forward-line 1))
                              (let ((header-pos (anything-get-previous-header-pos))
                                    (candidate-pos (anything-get-previous-candidate-separator-pos)))
                                (when header-pos
                                  (if (or (null candidate-pos) (&lt; candidate-pos header-pos))
                                      (goto-char header-pos)
                                    (goto-char candidate-pos))
                                  (forward-line 1))))))
                
                (t (error "<span class="quote">Invalid direction.</span>"))))

        (page (case direction
                (next (condition-case nil
                          (scroll-up)
                        (end-of-buffer (goto-char (point-max)))))
                (previous (condition-case nil
                              (scroll-down)
                            (beginning-of-buffer (goto-char (point-min)))))
                (t (error "<span class="quote">Invalid direction.</span>"))))

        (source (case direction
                   (next (goto-char (or (anything-get-next-header-pos)
                                        (point-min))))
                   (previous (progn
                               (forward-line -1)
                               (if (bobp)
                                   (goto-char (point-max))
                                 (if (anything-pos-header-line-p)
                                     (forward-line -1)
                                   (forward-line 1)))
                               (goto-char (anything-get-previous-header-pos))
                               (forward-line 1)))
                   (t (error "<span class="quote">Invalid direction.</span>"))))

        (t (error "<span class="quote">Invalid unit.</span>")))

      (while (and (not (bobp))
                  (or (anything-pos-header-line-p)
                      (anything-pos-candidate-separator-p)))
        (forward-line (if (and (eq direction 'previous)
                               (not (eq (line-beginning-position)
                                        (point-min))))
                          -1
                        1)))
      (if (bobp)
          (forward-line 1))
      (if (eobp)
          (forward-line -1))

      (when (and anything-display-source-at-screen-top (eq unit 'source))
        (set-window-start (selected-window)
                          (save-excursion (forward-line -1) (point))))
      (when (anything-get-previous-header-pos)
        (anything-mark-current-line)))))

(defun anything-mark-current-line ()
  "<span class="quote">Move selection overlay to current line.</span>"
  (move-overlay anything-selection-overlay
                (line-beginning-position)
                (if (anything-pos-multiline-p)
                    (let ((header-pos (anything-get-next-header-pos))
                          (candidate-pos (anything-get-next-candidate-separator-pos)))
                      (or (and (null header-pos) candidate-pos candidate-pos)
                          (and header-pos candidate-pos (&lt; candidate-pos header-pos) candidate-pos)
                          header-pos
                          (point-max)))
                  (1+ (line-end-position))))
  (anything-follow-execute-persistent-action-maybe))

(defun anything-select-with-digit-shortcut ()
  (interactive)
  (if anything-enable-digit-shortcuts
      (save-selected-window
        (select-window (anything-window))          
        (let* ((index (- (event-basic-type (elt (this-command-keys-vector) 0)) ?1))
               (overlay (nth index anything-digit-overlays)))
          (when (overlay-buffer overlay)
            (goto-char (overlay-start overlay))
            (anything-mark-current-line)
            (anything-exit-minibuffer))))))

(defun anything-exit-minibuffer ()
  "<span class="quote">Select the current candidate by exiting the minibuffer.</span>"
  (interactive)
  (declare (special anything-iswitchb-candidate-selected))
  (setq anything-iswitchb-candidate-selected (anything-get-selection))
  (exit-minibuffer))


(defun anything-get-next-header-pos ()
  "<span class="quote">Return the position of the next header from point.</span>"
  (next-single-property-change (point) 'anything-header))


(defun anything-get-previous-header-pos ()
  "<span class="quote">Return the position of the previous header from point</span>"
  (previous-single-property-change (point) 'anything-header))


(defun anything-pos-multiline-p ()
  "<span class="quote">Return non-nil if the current position is in the multiline source region.</span>"
  (get-text-property (point) 'anything-multiline))


(defun anything-get-next-candidate-separator-pos ()
  "<span class="quote">Return the position of the next candidate separator from point.</span>"
  (next-single-property-change (point) 'anything-candidate-separator))


(defun anything-get-previous-candidate-separator-pos ()
  "<span class="quote">Return the position of the previous candidate separator from point.</span>"
  (previous-single-property-change (point) 'anything-candidate-separator))


(defun anything-pos-header-line-p ()
  "<span class="quote">Return t if the current line is a header line.</span>"
  (or (get-text-property (line-beginning-position) 'anything-header)
      (get-text-property (line-beginning-position) 'anything-header-separator)))

(defun anything-pos-candidate-separator-p ()
  "<span class="quote">Return t if the current line is a candidate separator.</span>"
  (get-text-property (line-beginning-position) 'anything-candidate-separator))

<span class="linecomment">;; (@* "Core: error handling")</span>
(defun anything-log-error (&rest args)
  "<span class="quote">Accumulate error messages into `anything-issued-errors'.</span>"
  (let ((msg (apply 'format args)))
    (unless (member msg anything-issued-errors)
      (add-to-list 'anything-issued-errors msg))))

(defun anything-print-error-messages ()
  "<span class="quote">Print error messages in `anything-issued-errors'.</span>"
  (message "<span class="quote">%s</span>" (mapconcat 'identity (reverse anything-issued-errors) "<span class="quote">\n</span>")))


<span class="linecomment">;; (@* "Core: misc")</span>
(defun anything-kill-buffer-hook ()
  "<span class="quote">Remove tick entry from `anything-tick-hash' when killing a buffer.</span>"
  (loop for key being the hash-keys in anything-tick-hash
        if (string-match (format "<span class="quote">^%s/</span>" (regexp-quote (buffer-name))) key)
        do (remhash key anything-tick-hash)))
(add-hook 'kill-buffer-hook 'anything-kill-buffer-hook)

(defun anything-maybe-fit-frame ()
  "<span class="quote">Fit anything frame to its buffer, and put it at top right of display.
 To inhibit fitting, set `fit-frame-inhibit-fitting-flag' to t.
 You can set user options `fit-frame-max-width-percent' and
 `fit-frame-max-height-percent' to control max frame size.</span>"
  (declare (warn (unresolved 0)))
  (when (and (require 'fit-frame nil t)
             (boundp 'fit-frame-inhibit-fitting-flag)
             (not fit-frame-inhibit-fitting-flag)
             (anything-window))
    (ignore-errors
      (with-anything-window
        (fit-frame nil nil nil t)
        (modify-frame-parameters
         (selected-frame)
         `((left . ,(- (x-display-pixel-width) (+ (frame-pixel-width) 7)))
           (top . 0))))))) <span class="linecomment">; The (top . 0) shouldn't be necessary (Emacs bug).</span>

(defun anything-preselect (candidate-or-regexp)
  (when candidate-or-regexp
    (with-anything-window
      (goto-char (point-min))
      <span class="linecomment">;; go to first candidate of first source</span>
      (forward-line 1)
      (let ((start (point)))
        (unless (or (re-search-forward (concat "<span class="quote">^</span>" (regexp-quote candidate-or-regexp) "<span class="quote">$</span>") nil t)
                (progn (goto-char start)
                       (re-search-forward candidate-or-regexp nil t)))
          (goto-char start))
        (anything-mark-current-line)))))

(defun anything-delete-current-selection ()
  "<span class="quote">Delete the currently selected item.</span>"
  (interactive)
  (with-anything-window
    (cond ((anything-pos-multiline-p)
           (anything-aif (anything-get-next-candidate-separator-pos)
               (delete-region (point-at-bol)
                              (1+ (progn (goto-char it) (point-at-eol))))
             <span class="linecomment">;; last candidate</span>
             (goto-char (anything-get-previous-candidate-separator-pos))
             (delete-region (point-at-bol) (point-max)))
           (when (eobp)
             (goto-char (or (anything-get-previous-candidate-separator-pos)
                            (point-min)))
             (forward-line 1)))
          (t
           (delete-region (point-at-bol) (1+ (point-at-eol)))
           (when (eobp) (forward-line -1))))
    (anything-mark-current-line)))

(defun anything-delete-minibuffer-content ()
  "<span class="quote">Same as `delete-minibuffer-contents' but this is a command.</span>"
  (interactive)
  (delete-minibuffer-contents))

<span class="linecomment">;; (@* "Built-in plug-in: type")</span>
(defun anything-compile-source--type (source)
  (anything-aif (assoc-default 'type source)
      (append source (assoc-default it anything-type-attributes) nil)
    source))

<span class="linecomment">;; `define-anything-type-attribute' is public API.</span>

(defun anything-add-type-attribute (type definition)
  (anything-aif (assq type anything-type-attributes)
      (setq anything-type-attributes (delete it anything-type-attributes)))
  (push (cons type definition) anything-type-attributes))

(defvar anything-types nil)
(defun anything-document-type-attribute (type doc)
  (add-to-list 'anything-types type t)
  (put type 'anything-typeattrdoc
       (concat "<span class="quote">- </span>" (symbol-name type) "<span class="quote">\n\n</span>" doc "<span class="quote">\n</span>")))

(defadvice documentation-property (after anything-document-type-attribute activate)
  "<span class="quote">Hack to display type attributes' documentation as `anything-type-attributes' docstring.</span>"
  (when (eq symbol 'anything-type-attributes)
    (setq ad-return-value
          (concat ad-return-value "<span class="quote">\n\n++++ Types currently defined ++++\n</span>"
                  (mapconcat (lambda (sym) (get sym 'anything-typeattrdoc))
                             anything-types "<span class="quote">\n</span>")))))

<span class="linecomment">;; (@* "Built-in plug-in: dummy")</span>
(defun anything-dummy-candidate (candidate source)
  <span class="linecomment">;; `source' is defined in filtered-candidate-transformer</span>
  (list anything-pattern))  

(defun anything-compile-source--dummy (source)
  (if (assoc 'dummy source)
      (append '((candidates "<span class="quote">dummy</span>")
                (accept-empty)
                (match identity)
                (filtered-candidate-transformer . anything-dummy-candidate)
                (volatile))
              source)
    source))

<span class="linecomment">;; (@* "Built-in plug-in: candidates-in-buffer")</span>
(defun anything-candidates-in-buffer ()
  "<span class="quote">Get candidates from the candidates buffer according to `anything-pattern'.

BUFFER is `anything-candidate-buffer' by default.  Each
candidate must be placed in one line.  This function is meant to
be used in candidates-in-buffer or candidates attribute of an
anything source.  Especially fast for many (1000+) candidates.

eg.
 '((name . \"many files\")
   (init . (lambda () (with-current-buffer (anything-candidate-buffer 'local)
                        (insert-many-filenames))))
   (search re-search-forward)  ; optional
   (candidates-in-buffer)
   (type . file))

+===============================================================+
| The new way of making and narrowing candidates: Using buffers |
+===============================================================+

By default, `anything' makes candidates by evaluating the
candidates function, then narrows them by `string-match' for each
candidate.

But this way is very slow for many candidates. The new way is
storing all candidates in a buffer and narrowing them by
`re-search-forward'. Search function is customizable by search
attribute. The important point is that buffer processing is MUCH
FASTER than string list processing and is the Emacs way.

The init function writes all candidates to a newly-created
candidate buffer.  The candidates buffer is created or specified
by `anything-candidate-buffer'.  Candidates are stored in a line.

The candidates function narrows all candidates, IOW creates a
subset of candidates dynamically. It is the task of
`anything-candidates-in-buffer'.  As long as
`anything-candidate-buffer' is used,`(candidates-in-buffer)' is
sufficient in most cases.

Note that `(candidates-in-buffer)' is shortcut of three attributes:
  (candidates . anything-candidates-in-buffer)
  (volatile)
  (match identity)
And `(candidates-in-buffer . func)' is shortcut of three attributes:
  (candidates . func)
  (volatile)
  (match identity)
The expansion is performed in `anything-get-sources'.

The candidates-in-buffer attribute implies the volatile attribute.
The volatile attribute is needed because `anything-candidates-in-buffer'
creates candidates dynamically and need to be called everytime
`anything-pattern' changes.

Because `anything-candidates-in-buffer' plays the role of `match' attribute
function, specifying `(match identity)' makes the source slightly faster.

To customize `anything-candidates-in-buffer' behavior, use search,
get-line and search-from-end attributes. See also `anything-sources' docstring.
</span>"
  (declare (special source))
  (anything-candidates-in-buffer-1 (anything-candidate-buffer)
                                   anything-pattern
                                   (or (assoc-default 'get-line source)
                                       #'buffer-substring-no-properties)
                                   <span class="linecomment">;; use external variable `source'.</span>
                                   (or (assoc-default 'search source)
                                       (if (assoc 'search-from-end source)
                                           '(re-search-backward)
                                         '(re-search-forward)))
                                   (anything-candidate-number-limit source)
                                   (assoc 'search-from-end source)))

(defun* anything-candidates-in-buffer-1 (buffer &optional (pattern anything-pattern) (get-line-fn 'buffer-substring-no-properties) (search-fns '(re-search-forward)) (limit anything-candidate-number-limit) search-from-end)
  <span class="linecomment">;; buffer == nil when candidates buffer does not exist.</span>
  (when buffer
    (with-current-buffer buffer
      (let ((start-point (if search-from-end (point-max) (point-min)))
            (next-line-fn (if search-from-end
                              (lambda (x) (goto-char (max (1- (point-at-bol)) 1)))
                            #'forward-line))
            (endp (if search-from-end #'bobp #'eobp)))
        (goto-char (1- start-point))
        (if (string= pattern "<span class="quote"></span>")
            (delq nil (loop until (funcall endp)
                                    for i from 1 to limit
                                    collecting (funcall get-line-fn (point-at-bol) (point-at-eol))
                                    do (funcall next-line-fn 1)))
                    
          (let ((i 1)
                (next-line-fn (if search-from-end
                                  (lambda (x) (goto-char (max (point-at-bol) 1)))
                                #'forward-line))
                buffer-read-only
                matches exit newmatches)
            (progn
              (goto-char (point-min))
              (insert "<span class="quote">\n</span>")
              (goto-char (point-max))
              (insert "<span class="quote">\n</span>")
              (setq start-point (if search-from-end (point-max) (point-min)))
              (clrhash anything-cib-hash)
              (unwind-protect
                  (dolist (searcher search-fns)
                    (goto-char start-point)
                    (setq newmatches nil)
                    (loop while (funcall searcher pattern nil t)
                          if (or (funcall endp) (&lt; limit i))
                          do (setq exit t) (return)
                          else do
                          (let ((cand (funcall get-line-fn (point-at-bol) (point-at-eol))))
                            (unless (gethash cand anything-cib-hash)
                              (puthash cand t anything-cib-hash)
                              (incf i)
                              (push cand newmatches)))
                          (funcall next-line-fn 1))
                    (setq matches (append matches (nreverse newmatches)))
                    (if exit (return)))
                (goto-char (point-min))
                (delete-char 1)
                (goto-char (1- (point-max)))
                (delete-char 1)
                           
                (set-buffer-modified-p nil)))
            (delq nil matches)))))))


(defun anything-candidate-buffer (&optional create-or-buffer)
  "<span class="quote">Register and return a buffer containing candidates of current source.
`anything-candidate-buffer' searches buffer-local candidates buffer first,
then global candidates buffer.

Acceptable values of CREATE-OR-BUFFER:

- nil (omit)
  Only return the candidates buffer.
- a buffer
  Register a buffer as a candidates buffer.
- 'global
  Create a new global candidates buffer,
  named \" *anything candidates:SOURCE*\".
- other non-nil value
  Create a new global candidates buffer,
  named \" *anything candidates:SOURCE*ANYTHING-CURRENT-BUFFER\".
</span>"
  (let* ((gbufname (format "<span class="quote"> *anything candidates:%s*</span>" anything-source-name))
         (lbufname (concat gbufname (buffer-name anything-current-buffer)))
         buf)
    (when create-or-buffer
      (if (bufferp create-or-buffer)
          (setq anything-candidate-buffer-alist
                (cons (cons anything-source-name create-or-buffer)
                      (delete (assoc anything-source-name anything-candidate-buffer-alist)
                              anything-candidate-buffer-alist)))
        (add-to-list 'anything-candidate-buffer-alist
                     (cons anything-source-name create-or-buffer))
        (when (eq create-or-buffer 'global)
          (loop for b in (buffer-list)
                if (string-match (format "<span class="quote">^%s</span>" (regexp-quote gbufname)) (buffer-name b))
                do (kill-buffer b)))
        (with-current-buffer
            (get-buffer-create (if (eq create-or-buffer 'global) gbufname lbufname))
          (buffer-disable-undo)
          (erase-buffer)
          (font-lock-mode -1))))
    (or (get-buffer lbufname)
        (get-buffer gbufname)
        (anything-aif (assoc-default anything-source-name anything-candidate-buffer-alist)
            (and (buffer-live-p it) it)))))

(defun anything-compile-source--candidates-in-buffer (source)
  (anything-aif (assoc 'candidates-in-buffer source)
      (append source `((candidates . ,(or (cdr it) 'anything-candidates-in-buffer))
                       (volatile) (match identity)))
    source))

<span class="linecomment">;; (@* "Utility: select another action by key")</span>
(defun anything-select-nth-action (n)
  "<span class="quote">Select the nth action for the currently selected candidate.</span>"
  (setq anything-saved-selection (anything-get-selection))
  (unless anything-saved-selection
    (error "<span class="quote">Nothing is selected.</span>"))
  (setq anything-saved-action (cdr (elt (anything-get-action) n)))
  (anything-exit-minibuffer))

(defun anything-select-2nd-action ()
  "<span class="quote">Select the 2nd action for the currently selected candidate.</span>"
  (interactive)
  (anything-select-nth-action 1))

(defun anything-select-3rd-action ()
  "<span class="quote">Select the 3rd action for the currently selected candidate.</span>"
  (interactive)
  (anything-select-nth-action 2))

(defun anything-select-4th-action ()
  "<span class="quote">Select the 4th action for the currently selected candidate.</span>"
  (interactive)
  (anything-select-nth-action 3))

(defun anything-select-2nd-action-or-end-of-line ()
  "<span class="quote">Select the 2nd action for the currently selected candidate if the point is at the end of minibuffer.
Otherwise goto the end of minibuffer.</span>"
  (interactive)
  (if (eolp)
      (anything-select-nth-action 1)
    (end-of-line)))

<span class="linecomment">;; (@* "Utility: Persistent Action")</span>
(defmacro with-anything-display-same-window (&rest body)
  "<span class="quote">Make `pop-to-buffer' and `display-buffer' display in the same window.</span>"
  `(let ((display-buffer-function 'anything-persistent-action-display-buffer))
     ,@body))
(put 'with-anything-display-same-window 'lisp-indent-function 0)

(defun* anything-execute-persistent-action (&optional (attr 'persistent-action))
  "<span class="quote">If a candidate is selected then perform the associated action without quitting anything.</span>"
  (interactive)
  (save-selected-window
    (select-window (get-buffer-window (anything-buffer-get)))
    (select-window (setq minibuffer-scroll-window
                         (if (one-window-p t) (split-window)
                           (next-window (selected-window) 1))))
    (let ((anything-in-persistent-action t))
      (with-anything-display-same-window
        (anything-execute-selection-action
         nil
         (or (assoc-default attr (anything-get-current-source))
             (anything-get-action))
         t)
        (run-hooks 'anything-after-persistent-action-hook)))))

(defun anything-persistent-action-display-buffer (buf &optional not-this-window)
  "<span class="quote">Make `pop-to-buffer' and `display-buffer' display in the same window in persistent action.
If `anything-persistent-action-use-special-display' is non-nil and
BUF is to be displayed by `special-display-function', use it.
Otherwise ignores `special-display-buffer-names' and `special-display-regexps'.</span>"
  (let* ((name (buffer-name buf))
         display-buffer-function pop-up-windows
         (same-window-regexps
          (unless (and anything-persistent-action-use-special-display
                       (or (member name
                                   (mapcar (lambda (x) (or (car-safe x) x)) special-display-buffer-names))
                           (remove-if-not
                            (lambda (x) (string-match (or (car-safe x) x) name))
                            special-display-regexps)))
            '("<span class="quote">.</span>"))))
    (display-buffer buf not-this-window)))

<span class="linecomment">;; scroll-other-window(-down)? for persistent-action</span>
(defun anything-scroll-other-window-base (command)
  (save-selected-window
    (select-window
     (some-window
      (lambda (w) (not (string= anything-buffer (buffer-name (window-buffer w)))))
      'no-minibuffer 'current-frame))
    (call-interactively command)))

(defun anything-scroll-other-window ()
  "<span class="quote">Scroll other window (not *Anything* window) upward.</span>"
  (interactive)
  (anything-scroll-other-window-base (lambda ()
                                       (interactive)
                                       (scroll-up anything-scroll-amount))))
(defun anything-scroll-other-window-down ()
  "<span class="quote">Scroll other window (not *Anything* window) downward.</span>"
  (interactive)
  (anything-scroll-other-window-base (lambda ()
                                       (interactive)
                                       (scroll-down anything-scroll-amount))))

<span class="linecomment">;; (@* "Utility: Visible Mark")</span>
(defface anything-visible-mark
  '((((min-colors 88) (background dark))
     (:background "<span class="quote">green1</span>" :foreground "<span class="quote">black</span>"))
    (((background dark)) (:background "<span class="quote">green</span>" :foreground "<span class="quote">black</span>"))
    (((min-colors 88)) (:background "<span class="quote">green1</span>"))
    (t (:background "<span class="quote">green</span>")))
  "<span class="quote">Face for visible mark.</span>"
  :group 'anything)
(defvar anything-visible-mark-face 'anything-visible-mark)
(defvar anything-visible-mark-overlays nil)

(defun anything-clear-visible-mark ()
  (mapc 'delete-overlay anything-visible-mark-overlays)
  (setq anything-visible-mark-overlays nil))
(add-hook 'anything-after-initialize-hook 'anything-clear-visible-mark)

<span class="linecomment">;; (defun anything-toggle-visible-mark ()</span>
<span class="linecomment">;;   (interactive)</span>
<span class="linecomment">;;   (with-anything-window</span>
<span class="linecomment">;;     (anything-aif (loop for o in anything-visible-mark-overlays</span>
<span class="linecomment">;;                         when (equal (line-beginning-position) (overlay-start o))</span>
<span class="linecomment">;;                         do (return o))</span>
<span class="linecomment">;;         ;; delete</span>
<span class="linecomment">;;         (progn (delete-overlay it)</span>
<span class="linecomment">;;                (delq it anything-visible-mark-overlays))</span>
<span class="linecomment">;;       (let ((o (make-overlay (line-beginning-position) (1+ (line-end-position)))))</span>
<span class="linecomment">;;         (overlay-put o 'face anything-visible-mark-face)</span>
<span class="linecomment">;;         (overlay-put o 'source (assoc-default 'name (anything-get-current-source)))</span>
<span class="linecomment">;;         (overlay-put o 'string (buffer-substring (overlay-start o) (overlay-end o)))</span>
<span class="linecomment">;;         (add-to-list 'anything-visible-mark-overlays o)))))</span>

(defvar anything-c-marked-candidate-list nil)
(defun anything-toggle-visible-mark ()
  (interactive)
  (with-anything-window
    (anything-aif (loop for o in anything-visible-mark-overlays
                        when (equal (line-beginning-position) (overlay-start o))
                        do   (return o))
        <span class="linecomment">;; delete</span>
        (progn
          (setq anything-c-marked-candidate-list
                (remove
                 (buffer-substring-no-properties (point-at-bol) (point-at-eol)) anything-c-marked-candidate-list))
          (delete-overlay it)
          (delq it anything-visible-mark-overlays))
      (let ((o (make-overlay (line-beginning-position) (1+ (line-end-position)))))
        (overlay-put o 'face anything-visible-mark-face)
        (overlay-put o 'source (assoc-default 'name (anything-get-current-source)))
        (overlay-put o 'string (buffer-substring (overlay-start o) (overlay-end o)))
        (add-to-list 'anything-visible-mark-overlays o)
        (push (buffer-substring-no-properties (point-at-bol) (point-at-eol)) anything-c-marked-candidate-list)))
    (anything-next-line)))

(add-hook 'anything-after-initialize-hook (lambda ()
                                   (setq anything-c-marked-candidate-list nil)))

(add-hook 'anything-after-action-hook (lambda ()
                                   (setq anything-c-marked-candidate-list nil)))

(defun anything-revive-visible-mark ()
  (interactive)
  (with-current-buffer anything-buffer
    (loop for o in anything-visible-mark-overlays do
          (goto-char (point-min))
          (when (search-forward (overlay-get o 'string) nil t)
            (forward-line -1)
            (when (save-excursion
                    (goto-char (anything-get-previous-header-pos))
                    (equal (overlay-get o 'source)
                           (buffer-substring (line-beginning-position) (line-end-position))))
              (move-overlay o (line-beginning-position) (1+ (line-end-position))))))))
(add-hook 'anything-update-hook 'anything-revive-visible-mark)

(defun anything-next-visible-mark (&optional prev)
  (interactive)
  (with-anything-window
    (setq anything-visible-mark-overlays
          (sort* anything-visible-mark-overlays
                 '&lt; :key 'overlay-start))
    (let ((i (position-if (lambda (o) (&lt; (point) (overlay-start o)))
                          anything-visible-mark-overlays)))
      (when prev
          (if (not i) (setq i (length anything-visible-mark-overlays)))
          (if (equal (point) (overlay-start (nth (1- i) anything-visible-mark-overlays)))
              (setq i (1- i))))
      (when i
        (goto-char (overlay-start (nth (if prev (1- i) i) anything-visible-mark-overlays)))
        (anything-mark-current-line)))))

(defun anything-prev-visible-mark ()
  (interactive)
  (anything-next-visible-mark t))

<span class="linecomment">;; (@* "Utility: `find-file' integration")</span>
(defun anything-quit-and-find-file ()
  "<span class="quote">Drop into `find-file' from `anything' like `iswitchb-find-file'.
This command is a simple example of `anything-run-after-quit'.</span>"
  (interactive)
  (anything-run-after-quit 'call-interactively 'find-file))

<span class="linecomment">;; (@* "Utility: Selection Paste")</span>
(defun anything-yank-selection ()
  "<span class="quote">Set minibuffer contents to current selection.</span>"
  (interactive)
  (delete-minibuffer-contents)
  (insert (anything-get-selection nil t)))

(defun anything-kill-selection-and-quit ()
  "<span class="quote">Store current selection to kill ring.
You can paste it by typing C-y.</span>"
  (interactive)
  (anything-run-after-quit
   (lambda (sel)
     (kill-new sel)
     (message "<span class="quote">Killed: %s</span>" sel))
   (anything-get-selection nil t)))


<span class="linecomment">;; (@* "Utility: Automatical execution of persistent-action")</span>
(define-minor-mode anything-follow-mode
  "<span class="quote">If this mode is on, persistent action is executed everytime the cursor is moved.</span>"
  nil "<span class="quote"> AFollow</span>" :global t)

(defun anything-follow-execute-persistent-action-maybe ()
  "<span class="quote">Execute persistent action after `anything-input-idle-delay' secs when `anything-follow-mode' is enabled.</span>"
  (and anything-follow-mode
       (sit-for anything-input-idle-delay)
       (anything-window)
       (anything-get-selection)
       (save-excursion
         (anything-execute-persistent-action))))

<span class="linecomment">;; (@* "Utility: Incremental search within results (unmaintained)")</span>

(defvar anything-isearch-original-global-map nil
  "<span class="quote">Original global map before Anything isearch is started.</span>")

(defvar anything-isearch-original-message-timeout nil
  "<span class="quote">Original message timeout before Anything isearch is started.</span>")

(defvar anything-isearch-pattern nil
  "<span class="quote">The current isearch pattern.</span>")

(defvar anything-isearch-message-suffix "<span class="quote"></span>"
  "<span class="quote">Message suffix indicating the current state of the search.</span>")

(defvar anything-isearch-original-point nil
  "<span class="quote">Original position of point before isearch is started.</span>")

(defvar anything-isearch-original-window nil
  "<span class="quote">Original selected window before isearch is started.</span>")

(defvar anything-isearch-original-cursor-in-non-selected-windows nil
  "<span class="quote">Original value of cursor-in-non-selected-windows before isearch is started.</span>")

(defvar anything-isearch-original-post-command-hook nil
  "<span class="quote">Original value of post-command-hook before isearch is started.</span>")

(defvar anything-isearch-match-positions nil
  "<span class="quote">Stack of positions of matches or non-matches.

It's a list of plists with two properties: `event', the last user
 event, `start', the start position of the current match, and
 `pos', the position of point after that event.

The value of `event' can be the following symbols: `char' if a
character was typed, `error' if a non-matching character was
typed, `search' if a forward search had to be done after a
character, and `search-again' if a search was done for the next
occurrence of the current pattern.</span>")

(defvar anything-isearch-match-start nil
  "<span class="quote">Start position of the current match.</span>")


(defun anything-isearch ()
  "<span class="quote">Start incremental search within results. (UNMAINTAINED)</span>"
  (interactive)
  (if (zerop (buffer-size (get-buffer (anything-buffer-get))))
      (message "<span class="quote">There are no results.</span>")

    (setq anything-isearch-original-message-timeout minibuffer-message-timeout)
    (setq minibuffer-message-timeout nil)

    (setq anything-isearch-original-global-map global-map)

    (condition-case nil
        (progn
          (setq anything-isearch-original-window (selected-window))
          (select-window (anything-window))
          (setq cursor-type t)

          (setq anything-isearch-original-post-command-hook
                (default-value 'post-command-hook))
          (setq-default post-command-hook nil)
          (add-hook 'post-command-hook 'anything-isearch-post-command)

          (use-global-map anything-isearch-map)
          (setq overriding-terminal-local-map anything-isearch-map)

          (setq anything-isearch-pattern "<span class="quote"></span>")

          (setq anything-isearch-original-cursor-in-non-selected-windows
                cursor-in-non-selected-windows)
          (setq cursor-in-non-selected-windows nil) 

          (setq anything-isearch-original-point (point-marker))
          (goto-char (point-min))
          (forward-line)
          (anything-mark-current-line)

          (setq anything-isearch-match-positions nil)
          (setq anything-isearch-match-start (point-marker))

          (if anything-isearch-overlay
              <span class="linecomment">;; make sure the overlay belongs to the anything buffer</span>
              (move-overlay anything-isearch-overlay (point-min) (point-min)
                            (get-buffer (anything-buffer-get)))

            (setq anything-isearch-overlay (make-overlay (point-min) (point-min)))
            (overlay-put anything-isearch-overlay 'face anything-isearch-match-face))

          (setq anything-isearch-message-suffix
                (substitute-command-keys "<span class="quote">cancel with \\[anything-isearch-cancel]</span>")))

      (error (anything-isearch-cleanup)))))


(defun anything-isearch-post-command ()
  "<span class="quote">Print the current pattern after every command.</span>"
  (anything-isearch-message)
  (when (anything-window)
    (with-anything-window
      (move-overlay anything-isearch-overlay anything-isearch-match-start (point)
                    (get-buffer (anything-buffer-get))))))


(defun anything-isearch-printing-char ()
  "<span class="quote">Add printing char to the pattern.</span>"
  (interactive)
  (let ((char (char-to-string last-command-char)))
    (setq anything-isearch-pattern (concat anything-isearch-pattern char))

    (with-anything-window
      (if (looking-at char)
          (progn
            (push (list 'event 'char
                        'start anything-isearch-match-start
                        'pos (point-marker))
                  anything-isearch-match-positions)
            (forward-char))

        (let ((start (point)))
          (while (and (re-search-forward anything-isearch-pattern nil t)
                      (anything-pos-header-line-p)))
          (if (or (anything-pos-header-line-p)
                  (eq start (point)))
              (progn
                (goto-char start)
                (push (list 'event 'error
                            'start anything-isearch-match-start
                            'pos (point-marker))
                      anything-isearch-match-positions))

            (push (list 'event 'search
                        'start anything-isearch-match-start
                        'pos (copy-marker start))
                  anything-isearch-match-positions)
            (setq anything-isearch-match-start (copy-marker (match-beginning 0))))))
  
      (anything-mark-current-line))))


(defun anything-isearch-again ()
  "<span class="quote">Search again for the current pattern</span>"
  (interactive)
  (if (equal anything-isearch-pattern "<span class="quote"></span>")
      (setq anything-isearch-message-suffix "<span class="quote">no pattern yet</span>")

    (with-anything-window
      (let ((start (point)))
        (while (and (re-search-forward anything-isearch-pattern nil t)
                    (anything-pos-header-line-p)))
        (if (or (anything-pos-header-line-p)
                (eq start (point)))
            (progn
              (goto-char start)
              (unless (eq 'error (plist-get (car anything-isearch-match-positions)
                                            'event))
                (setq anything-isearch-message-suffix "<span class="quote">no more matches</span>")))

          (push (list 'event 'search-again
                      'start anything-isearch-match-start
                      'pos (copy-marker start))
                anything-isearch-match-positions)
          (setq anything-isearch-match-start (copy-marker (match-beginning 0)))

          (anything-mark-current-line))))))


(defun anything-isearch-delete ()
  "<span class="quote">Undo last event.</span>"
  (interactive)
  (unless (equal anything-isearch-pattern "<span class="quote"></span>")
    (let ((last (pop anything-isearch-match-positions)))
      (unless (eq 'search-again (plist-get last 'event))
        (setq anything-isearch-pattern
              (substring anything-isearch-pattern 0 -1)))

      (with-anything-window      
        (goto-char (plist-get last 'pos))
        (setq anything-isearch-match-start (plist-get last 'start))
        (anything-mark-current-line)))))


(defun anything-isearch-default-action ()
  "<span class="quote">Execute the default action for the selected candidate.</span>"
  (interactive)
  (anything-isearch-cleanup)
  (with-current-buffer (anything-buffer-get) (anything-exit-minibuffer)))


(defun anything-isearch-select-action ()
  "<span class="quote">Choose an action for the selected candidate.</span>"
  (interactive)
  (anything-isearch-cleanup)
  (with-anything-window
    (anything-select-action)))


(defun anything-isearch-cancel ()
  "<span class="quote">Cancel Anything isearch.</span>"
  (interactive)
  (anything-isearch-cleanup)
  (when (anything-window)
    (with-anything-window
      (goto-char anything-isearch-original-point)
      (anything-mark-current-line))))


(defun anything-isearch-cleanup ()
  "<span class="quote">Clean up the mess.</span>"
  (setq minibuffer-message-timeout anything-isearch-original-message-timeout)
  (with-current-buffer (anything-buffer-get)
    (setq overriding-terminal-local-map nil)
    (setq cursor-type nil)
    (setq cursor-in-non-selected-windows
          anything-isearch-original-cursor-in-non-selected-windows))
  (when anything-isearch-original-window
    (select-window anything-isearch-original-window))

  (use-global-map anything-isearch-original-global-map)
  (setq-default post-command-hook anything-isearch-original-post-command-hook)
  (when (overlayp anything-isearch-overlay) 
    (delete-overlay anything-isearch-overlay)))


(defun anything-isearch-message ()
  "<span class="quote">Print prompt.</span>"
  (if (and (equal anything-isearch-message-suffix "<span class="quote"></span>")
           (eq (plist-get (car anything-isearch-match-positions) 'event)
               'error))
      (setq anything-isearch-message-suffix "<span class="quote">failing</span>"))

  (unless (equal anything-isearch-message-suffix "<span class="quote"></span>")
    (setq anything-isearch-message-suffix 
          (concat "<span class="quote"> [</span>" anything-isearch-message-suffix "<span class="quote">]</span>")))

  (message (concat "<span class="quote">Search within results: </span>"
                   anything-isearch-pattern
                   anything-isearch-message-suffix))

  (setq anything-isearch-message-suffix "<span class="quote"></span>"))


<span class="linecomment">;; (@* "Utility: Iswitchb integration (unmaintained)")</span>

(defvar anything-iswitchb-candidate-selected nil
  "<span class="quote">Indicates whether an anything candidate is selected from iswitchb.</span>")

(defvar anything-iswitchb-frame-configuration nil
  "<span class="quote">Saved frame configuration, before anything buffer was displayed.</span>")

(defvar anything-iswitchb-saved-keys nil
  "<span class="quote">The original in iswitchb before binding anything keys.</span>")


(defun anything-iswitchb-setup ()
  "<span class="quote">Integrate anything completion into iswitchb (UNMAINTAINED).

If the user is idle for `anything-iswitchb-idle-delay' seconds
after typing something into iswitchb then anything candidates are
shown for the current iswitchb input.

ESC cancels anything completion and returns to normal iswitchb.

Some key bindings in `anything-map' are modified.
See also `anything-iswitchb-setup-keys'.</span>"
  (interactive)

  (require 'iswitchb)

  <span class="linecomment">;; disable timid completion during iswitchb</span>
  (put 'iswitchb-buffer 'timid-completion 'disabled)
  (add-hook 'minibuffer-setup-hook  'anything-iswitchb-minibuffer-setup)

  (defadvice iswitchb-visit-buffer
    (around anything-iswitchb-visit-buffer activate)
    (if anything-iswitchb-candidate-selected
        (anything-execute-selection-action)
      ad-do-it))

  (defadvice iswitchb-possible-new-buffer
    (around anything-iswitchb-possible-new-buffer activate)
    (if anything-iswitchb-candidate-selected
        (anything-execute-selection-action)
      ad-do-it))
  (anything-iswitchb-setup-keys)
  (message "<span class="quote">Iswitchb integration is activated.</span>"))

(defun anything-iswitchb-setup-keys ()
  "<span class="quote">Modify `anything-map' for anything-iswitchb users.

C-p is used instead of M-p, because anything uses ESC
 (currently hardcoded) for `anything-iswitchb-cancel-anything' and
Emacs handles ESC and Meta as synonyms, so ESC overrides
other commands with Meta prefix.

Note that iswitchb uses M-p and M-n by default for history
navigation, so you should bind C-p and C-n in
`iswitchb-mode-map' if you use the history keys and don't want
to use different keys for iswitchb while anything is not yet
kicked in. These keys are not bound automatically by anything
in `iswitchb-mode-map' because they (C-n at least) already have
a standard iswitchb binding which you might be accustomed to.

Binding M-s is used instead of C-s, because C-s has a binding in
iswitchb.  You can rebind it AFTER `anything-iswitchb-setup'.

Unbind C-r to prevent problems during anything-isearch.</span>"
  (define-key anything-map (kbd "<span class="quote">C-s</span>") nil)
  (define-key anything-map (kbd "<span class="quote">M-p</span>") nil)
  (define-key anything-map (kbd "<span class="quote">M-n</span>") nil)
  (define-key anything-map (kbd "<span class="quote">M-v</span>") nil)
  (define-key anything-map (kbd "<span class="quote">C-v</span>") nil)
  (define-key anything-map (kbd "<span class="quote">C-p</span>") 'anything-previous-history-element)
  (define-key anything-map (kbd "<span class="quote">C-n</span>") 'anything-next-history-element)
  (define-key anything-map (kbd "<span class="quote">M-s</span>") nil)
  (define-key anything-map (kbd "<span class="quote">M-s</span>") 'anything-isearch)
  (define-key anything-map (kbd "<span class="quote">C-r</span>") nil))

(defun anything-iswitchb-minibuffer-setup ()
  (when (eq this-command 'iswitchb-buffer)
    (add-hook 'minibuffer-exit-hook  'anything-iswitchb-minibuffer-exit)

    (setq anything-iswitchb-frame-configuration nil)
    (setq anything-iswitchb-candidate-selected nil)
    (add-hook 'anything-update-hook 'anything-iswitchb-handle-update)

    (anything-initialize)
    
    (add-hook 'post-command-hook 'anything-iswitchb-check-input)))


(defun anything-iswitchb-minibuffer-exit ()
  (remove-hook 'minibuffer-exit-hook  'anything-iswitchb-minibuffer-exit)
  (remove-hook 'post-command-hook 'anything-iswitchb-check-input)
  (remove-hook 'anything-update-hook 'anything-iswitchb-handle-update)

  (anything-cleanup)

  (when anything-iswitchb-frame-configuration
    (anything-set-frame/window-configuration anything-iswitchb-frame-configuration)
    (setq anything-iswitchb-frame-configuration nil)))


(defun anything-iswitchb-check-input ()
  "<span class="quote">Extract iswitchb input and check if it needs to be handled.</span>"
  (declare (special iswitchb-text))
  (if (or anything-iswitchb-frame-configuration
          (sit-for anything-iswitchb-idle-delay))
      (anything-check-new-input iswitchb-text)))


(defun anything-iswitchb-handle-update ()
  "<span class="quote">Pop up the anything buffer if it's not empty and it's not
shown yet and bind anything commands in iswitchb.</span>"
  (unless (or (equal (buffer-size (get-buffer anything-buffer)) 0)
              anything-iswitchb-frame-configuration)
    (setq anything-iswitchb-frame-configuration (anything-current-frame/window-configuration))

    (save-selected-window 
      (if (not anything-samewindow)
          (pop-to-buffer anything-buffer)

        (select-window (get-lru-window))
        (switch-to-buffer anything-buffer)))

    (with-current-buffer (window-buffer (active-minibuffer-window))
      (let* ((anything-prefix "<span class="quote">anything-</span>")
             (prefix-length (length anything-prefix))
             (commands 
              (delete-dups
               (remove-if 'null
                          (mapcar 
                           (lambda (binding)
                             (let ((command (cdr binding)))
                               (when (and (symbolp command)
                                          (eq (compare-strings 
                                               anything-prefix 
                                               0 prefix-length
                                               (symbol-name command)
                                               0 prefix-length)
                                              t))
                                 command)))
                           (cdr anything-map)))))
             (bindings (mapcar (lambda (command)
                                 (cons command 
                                       (where-is-internal command anything-map)))
                               commands)))

        (push (list 'anything-iswitchb-cancel-anything (kbd "<span class="quote">&lt;ESC&gt;</span>"))
              bindings)

        (setq anything-iswitchb-saved-keys nil)

      (let* ((iswitchb-prefix "<span class="quote">iswitchb-</span>")
             (prefix-length (length iswitchb-prefix)))
        (dolist (binding bindings)
          (dolist (key (cdr binding))
            (let ((old-command (lookup-key (current-local-map) key)))
              (unless (and anything-iswitchb-dont-touch-iswithcb-keys
                           (symbolp old-command)
                           (eq (compare-strings iswitchb-prefix 
                                                0 prefix-length
                                                (symbol-name old-command)
                                                0 prefix-length)
                               t))
                (push (cons key old-command)
                      anything-iswitchb-saved-keys)
                (define-key (current-local-map) key (car binding)))))))))))


(defun anything-iswitchb-cancel-anything ()
  "<span class="quote">Cancel anything completion and return to standard iswitchb.</span>"
  (interactive)
  (save-excursion
    (dolist (binding anything-iswitchb-saved-keys)
      (define-key (current-local-map) (car binding) (cdr binding)))
    (anything-iswitchb-minibuffer-exit)))

<span class="linecomment">;; (@* "Compatibility")</span>

<span class="linecomment">;; Copied assoc-default from XEmacs version 21.5.12</span>
(unless (fboundp 'assoc-default)
  (defun assoc-default (key alist &optional test default)
    "<span class="quote">Find object KEY in a pseudo-alist ALIST.
ALIST is a list of conses or objects.  Each element (or the element's car,
if it is a cons) is compared with KEY by evaluating (TEST (car elt) KEY).
If that is non-nil, the element matches;
then `assoc-default' returns the element's cdr, if it is a cons,
or DEFAULT if the element is not a cons.

If no element matches, the value is nil.
If TEST is omitted or nil, `equal' is used.</span>"
    (let (found (tail alist) value)
      (while (and tail (not found))
        (let ((elt (car tail)))
          (when (funcall (or test 'equal) (if (consp elt) (car elt) elt) key)
            (setq found t value (if (consp elt) (cdr elt) default))))
        (setq tail (cdr tail)))
      value)))

<span class="linecomment">;; Function not available in XEmacs, </span>
(unless (fboundp 'minibuffer-contents)
  (defun minibuffer-contents ()
    "<span class="quote">Return the user input in a minbuffer as a string.
The current buffer must be a minibuffer.</span>"
    (field-string (point-max)))

  (defun delete-minibuffer-contents  ()
    "<span class="quote">Delete all user input in a minibuffer.
The current buffer must be a minibuffer.</span>"
    (delete-field (point-max))))

<span class="linecomment">;; Function not available in older Emacs (&lt;= 22.1).</span>
(unless (fboundp 'buffer-chars-modified-tick)
  (defun buffer-chars-modified-tick (&optional buffer)
    "<span class="quote">Return BUFFER's character-change tick counter.
Each buffer has a character-change tick counter, which is set to the
value of the buffer's tick counter (see `buffer-modified-tick'), each
time text in that buffer is inserted or deleted.  By comparing the
values returned by two individual calls of `buffer-chars-modified-tick',
you can tell whether a character change occurred in that buffer in
between these calls.  No argument or nil as argument means use current
buffer as BUFFER.</span>"
    (with-current-buffer (or buffer (current-buffer))
      (if (listp buffer-undo-list)
          (length buffer-undo-list)
        (buffer-modified-tick)))))


<span class="linecomment">;; (@* "Unit Tests")</span>

(defun* anything-test-candidates (sources &optional (input "<span class="quote"></span>") (compile-source-functions anything-compile-source-functions-default))
  "<span class="quote">Test helper function for anything.
Given pseudo `anything-sources' and `anything-pattern', returns list like
  ((\"source name1\" (\"candidate1\" \"candidate2\"))
   (\"source name2\" (\"candidate3\" \"candidate4\")))
</span>"
  (let ((anything-test-mode t)
        anything-enable-digit-shortcuts
        anything-candidate-cache
        (anything-sources (anything-normalize-sources sources))
        (anything-compile-source-functions compile-source-functions)
        anything-before-initialize-hook
        anything-after-initialize-hook
        anything-update-hook
        anything-test-candidate-list)
    (get-buffer-create anything-buffer)

    (anything-initialize)
    (setq anything-input input anything-pattern input)
    (anything-update)
    <span class="linecomment">;; test-mode spec: select 1st candidate!</span>
    (with-current-buffer anything-buffer
      (forward-line 1)
      (anything-mark-current-line))
    (prog1
        anything-test-candidate-list
      (anything-cleanup))))

(defmacro anything-test-update (sources pattern)
  "<span class="quote">Test helper macro for anything. It is meant for testing *anything* buffer contents.</span>"
  `(progn (stub anything-get-sources =&gt; ,sources)
          (stub run-hooks =&gt; nil)
          (stub anything-maybe-fit-frame =&gt; nil)
          (stub run-with-idle-timer =&gt; nil)
          (let (anything-test-mode (anything-pattern ,pattern))
            (anything-update))))

<span class="linecomment">;;;; unit test</span>
<span class="linecomment">;; (install-elisp "http://www.emacswiki.org/cgi-bin/wiki/download/el-expectations.el")</span>
<span class="linecomment">;; (install-elisp "http://www.emacswiki.org/cgi-bin/wiki/download/el-mock.el")</span>
(dont-compile
  (when (fboundp 'expectations)
    (expectations
      (desc "<span class="quote">anything-current-buffer</span>")
      (expect "<span class="quote">__a_buffer</span>"
        (with-current-buffer (get-buffer-create "<span class="quote">__a_buffer</span>")
          (anything-test-candidates '(((name . "<span class="quote">FOO</span>"))) "<span class="quote"></span>")
          (prog1
              (buffer-name anything-current-buffer)
            (kill-buffer "<span class="quote">__a_buffer</span>")
            )))
      (desc "<span class="quote">anything-buffer-file-name</span>")
      (expect (regexp "<span class="quote">/__a_file__</span>")
        (with-current-buffer (get-buffer-create "<span class="quote">__a_file__</span>")
          (setq buffer-file-name "<span class="quote">/__a_file__</span>")
          (anything-test-candidates '(((name . "<span class="quote">FOO</span>"))) "<span class="quote"></span>")
          (prog1
              anything-buffer-file-name
            <span class="linecomment">;;(kill-buffer "__a_file__")</span>
            )))
      (desc "<span class="quote">anything-compile-sources</span>")
      (expect '(((name . "<span class="quote">foo</span>")))
        (anything-compile-sources '(((name . "<span class="quote">foo</span>"))) nil)
        )
      (expect '(((name . "<span class="quote">foo</span>") (type . test) (action . identity)))
        (let ((anything-type-attributes '((test (action . identity)))))
          (anything-compile-sources '(((name . "<span class="quote">foo</span>") (type . test)))
                                    '(anything-compile-source--type))))
      (desc "<span class="quote">anything-sources accepts symbols</span>")
      (expect '(((name . "<span class="quote">foo</span>")))
        (let* ((foo '((name . "<span class="quote">foo</span>"))))
          (anything-compile-sources '(foo) nil)))
      (desc "<span class="quote">anything-get-sources action</span>")
      (expect '(((name . "<span class="quote">Actions</span>") (candidates . actions)))
        (stub anything-action-window =&gt; t)
        (let (anything-compiled-sources
              (anything-sources '(((name . "<span class="quote">Actions</span>") (candidates . actions)))))
          (anything-get-sources)))
      (desc "<span class="quote">get-buffer-create candidates-buffer</span>")
      (expect '(((name . "<span class="quote">many</span>") (init . many-init)
                 (candidates-in-buffer . anything-candidates-in-buffer)
                 (candidates . anything-candidates-in-buffer)
                 (volatile) (match identity)))
        (anything-compile-sources
         '(((name . "<span class="quote">many</span>") (init . many-init)
            (candidates-in-buffer . anything-candidates-in-buffer)))
         '(anything-compile-source--candidates-in-buffer)))
      (expect '(((name . "<span class="quote">many</span>") (init . many-init)
                 (candidates-in-buffer)
                 (candidates . anything-candidates-in-buffer)
                 (volatile) (match identity)))
        (anything-compile-sources
         '(((name . "<span class="quote">many</span>") (init . many-init)
            (candidates-in-buffer)))
         '(anything-compile-source--candidates-in-buffer)))
      (expect '(((name . "<span class="quote">many</span>") (init . many-init)
                 (candidates-in-buffer)
                 (type . test)
                 (action . identity)
                 (candidates . anything-candidates-in-buffer)
                 (volatile) (match identity)))
        (let ((anything-type-attributes '((test (action . identity)))))
          (anything-compile-sources
           '(((name . "<span class="quote">many</span>") (init . many-init)
              (candidates-in-buffer)
              (type . test)))
           '(anything-compile-source--type
             anything-compile-source--candidates-in-buffer))))

      (desc "<span class="quote">anything-get-candidates</span>")
      (expect '("<span class="quote">foo</span>" "<span class="quote">bar</span>")
        (anything-get-candidates '((name . "<span class="quote">foo</span>") (candidates "<span class="quote">foo</span>" "<span class="quote">bar</span>"))))
      (expect '("<span class="quote">FOO</span>" "<span class="quote">BAR</span>")
        (anything-get-candidates '((name . "<span class="quote">foo</span>") (candidates "<span class="quote">foo</span>" "<span class="quote">bar</span>")
                                   (candidate-transformer
                                    . (lambda (cands) (mapcar 'upcase cands))))))
      (expect '("<span class="quote">foo</span>" "<span class="quote">bar</span>")
        (anything-get-candidates '((name . "<span class="quote">foo</span>")
                                   (candidates . (lambda () '("<span class="quote">foo</span>" "<span class="quote">bar</span>"))))))
      (desc "<span class="quote">anything-compute-matches</span>")
      (expect '("<span class="quote">foo</span>" "<span class="quote">bar</span>")
        (let ((anything-pattern "<span class="quote"></span>"))
          (anything-compute-matches '((name . "<span class="quote">FOO</span>") (candidates "<span class="quote">foo</span>" "<span class="quote">bar</span>") (volatile)))))
      (expect '("<span class="quote">foo</span>")
        (let ((anything-pattern "<span class="quote">oo</span>"))
          (anything-compute-matches '((name . "<span class="quote">FOO</span>") (candidates "<span class="quote">foo</span>" "<span class="quote">bar</span>") (volatile)))))
      (expect '("<span class="quote">bar</span>")
        (let ((anything-pattern "<span class="quote">^b</span>"))
          (anything-compute-matches '((name . "<span class="quote">FOO</span>") (candidates "<span class="quote">foo</span>" "<span class="quote">bar</span>") (volatile)))))
      (expect '("<span class="quote">a</span>" "<span class="quote">b</span>")
        (let ((anything-pattern "<span class="quote"></span>")
              (anything-candidate-number-limit 2))
          (anything-compute-matches '((name . "<span class="quote">FOO</span>") (candidates "<span class="quote">a</span>" "<span class="quote">b</span>" "<span class="quote">c</span>") (volatile)))))
      (expect '("<span class="quote">a</span>" "<span class="quote">b</span>")
        (let ((anything-pattern "<span class="quote">.</span>")
              (anything-candidate-number-limit 2))
          (anything-compute-matches '((name . "<span class="quote">FOO</span>") (candidates "<span class="quote">a</span>" "<span class="quote">b</span>" "<span class="quote">c</span>") (volatile)))))
      (expect '("<span class="quote">a</span>" "<span class="quote">b</span>" "<span class="quote">c</span>")
        (let ((anything-pattern "<span class="quote"></span>")
              anything-candidate-number-limit)
          (anything-compute-matches '((name . "<span class="quote">FOO</span>") (candidates "<span class="quote">a</span>" "<span class="quote">b</span>" "<span class="quote">c</span>") (volatile)))))
      (expect '("<span class="quote">a</span>" "<span class="quote">b</span>" "<span class="quote">c</span>")
        (let ((anything-pattern "<span class="quote">[abc]</span>")
              anything-candidate-number-limit)
          (anything-compute-matches '((name . "<span class="quote">FOO</span>") (candidates "<span class="quote">a</span>" "<span class="quote">b</span>" "<span class="quote">c</span>") (volatile)))))
      <span class="linecomment">;; using anything-test-candidate-list</span>
      (desc "<span class="quote">anything-test-candidates</span>")
      (expect '(("<span class="quote">FOO</span>" ("<span class="quote">foo</span>" "<span class="quote">bar</span>")))
        (anything-test-candidates '(((name . "<span class="quote">FOO</span>") (candidates "<span class="quote">foo</span>" "<span class="quote">bar</span>")))))
      (expect '(("<span class="quote">FOO</span>" ("<span class="quote">bar</span>")))
        (anything-test-candidates '(((name . "<span class="quote">FOO</span>") (candidates "<span class="quote">foo</span>" "<span class="quote">bar</span>"))) "<span class="quote">ar</span>"))
      (expect '(("<span class="quote">T1</span>" ("<span class="quote">hoge</span>" "<span class="quote">aiue</span>"))
                ("<span class="quote">T2</span>" ("<span class="quote">test</span>" "<span class="quote">boke</span>")))
        (anything-test-candidates '(((name . "<span class="quote">T1</span>") (candidates "<span class="quote">hoge</span>" "<span class="quote">aiue</span>"))
                                    ((name . "<span class="quote">T2</span>") (candidates "<span class="quote">test</span>" "<span class="quote">boke</span>")))))
      (expect '(("<span class="quote">T1</span>" ("<span class="quote">hoge</span>"))
                ("<span class="quote">T2</span>" ("<span class="quote">boke</span>")))
        (anything-test-candidates '(((name . "<span class="quote">T1</span>") (candidates "<span class="quote">hoge</span>" "<span class="quote">aiue</span>"))
                                    ((name . "<span class="quote">T2</span>") (candidates "<span class="quote">test</span>" "<span class="quote">boke</span>"))) "<span class="quote">o</span>"))
      (desc "<span class="quote">requires-pattern attribute</span>")
      (expect nil
        (anything-test-candidates '(((name . "<span class="quote">FOO</span>") (candidates "<span class="quote">foo</span>" "<span class="quote">bar</span>")
                                     (requires-pattern . 1)))))
      (expect '(("<span class="quote">FOO</span>" ("<span class="quote">bar</span>")))
        (anything-test-candidates '(((name . "<span class="quote">FOO</span>") (candidates "<span class="quote">foo</span>" "<span class="quote">bar</span>")
                                     (requires-pattern . 1))) "<span class="quote">b</span>"))
      (desc "<span class="quote">delayed attribute(for test)</span>")
      (expect '(("<span class="quote">T2</span>" ("<span class="quote">boke</span>"))
                ("<span class="quote">T1</span>" ("<span class="quote">hoge</span>")))
        (anything-test-candidates
         '(((name . "<span class="quote">T1</span>") (candidates "<span class="quote">hoge</span>" "<span class="quote">aiue</span>") (delayed))
           ((name . "<span class="quote">T2</span>") (candidates "<span class="quote">test</span>" "<span class="quote">boke</span>")))
         "<span class="quote">o</span>"))
      (desc "<span class="quote">match attribute(prefix search)</span>")
      (expect '(("<span class="quote">FOO</span>" ("<span class="quote">bar</span>")))
        (anything-test-candidates
         '(((name . "<span class="quote">FOO</span>") (candidates "<span class="quote">foo</span>" "<span class="quote">bar</span>")
            (match (lambda (c) (string-match (concat "<span class="quote">^</span>" anything-pattern) c)))))
         "<span class="quote">ba</span>"))
      (expect nil
        (anything-test-candidates
         '(((name . "<span class="quote">FOO</span>") (candidates "<span class="quote">foo</span>" "<span class="quote">bar</span>")
            (match (lambda (c) (string-match (concat "<span class="quote">^</span>" anything-pattern) c)))))
         "<span class="quote">ar</span>"))
      (desc "<span class="quote">init attribute</span>")
      (expect '(("<span class="quote">FOO</span>" ("<span class="quote">bar</span>")))
        (let (v)
          (anything-test-candidates
           '(((name . "<span class="quote">FOO</span>") (init . (lambda () (setq v '("<span class="quote">foo</span>" "<span class="quote">bar</span>"))))
              (candidates . v)))
           "<span class="quote">ar</span>")))
      (desc "<span class="quote">candidate-transformer attribute</span>")
      (expect '(("<span class="quote">FOO</span>" ("<span class="quote">BAR</span>")))
        (anything-test-candidates '(((name . "<span class="quote">FOO</span>") (candidates "<span class="quote">foo</span>" "<span class="quote">bar</span>")
                                     (candidate-transformer
                                      . (lambda (cands) (mapcar 'upcase cands)))))
                                  "<span class="quote">ar</span>"))
      (desc "<span class="quote">filtered-candidate-transformer attribute</span>")
      <span class="linecomment">;; needs more tests</span>
      (expect '(("<span class="quote">FOO</span>" ("<span class="quote">BAR</span>")))
        (anything-test-candidates '(((name . "<span class="quote">FOO</span>") (candidates "<span class="quote">foo</span>" "<span class="quote">bar</span>")
                                     (filtered-candidate-transformer
                                      . (lambda (cands src) (mapcar 'upcase cands)))))
                                  "<span class="quote">ar</span>"))
      (desc "<span class="quote">anything-candidates-in-buffer-1</span>")
      (expect nil
        (anything-candidates-in-buffer-1 nil))
      (expect '("<span class="quote">foo+</span>" "<span class="quote">bar+</span>" "<span class="quote">baz+</span>")
        (with-temp-buffer
          (insert "<span class="quote">foo+\nbar+\nbaz+\n</span>")
          (let ((anything-candidate-number-limit 5))
            (anything-candidates-in-buffer-1 (current-buffer) "<span class="quote"></span>"))))
      (expect '("<span class="quote">foo+</span>" "<span class="quote">bar+</span>")
        (with-temp-buffer
          (insert "<span class="quote">foo+\nbar+\nbaz+\n</span>")
          (let ((anything-candidate-number-limit 2))
            (anything-candidates-in-buffer-1 (current-buffer) "<span class="quote"></span>"))))
      (expect '("<span class="quote">foo+</span>")
        (with-temp-buffer
          (insert "<span class="quote">foo+\nbar+\nbaz+\n</span>")
          (anything-candidates-in-buffer-1 (current-buffer) "<span class="quote">oo\\+</span>")))
      (expect '("<span class="quote">foo+</span>")
        (with-temp-buffer
          (insert "<span class="quote">foo+\nbar+\nbaz+\n</span>")
          (anything-candidates-in-buffer-1 
           (current-buffer) "<span class="quote">oo+</span>"
           #'buffer-substring-no-properties '(search-forward))))
      (expect '(("<span class="quote">foo+</span>" "<span class="quote">FOO+</span>"))
        (with-temp-buffer
          (insert "<span class="quote">foo+\nbar+\nbaz+\n</span>")
          (anything-candidates-in-buffer-1
           (current-buffer) "<span class="quote">oo\\+</span>"
           (lambda (s e)
             (let ((l (buffer-substring-no-properties s e)))
               (list l (upcase l)))))))
      (desc "<span class="quote">anything-candidates-in-buffer</span>")
      (expect '(("<span class="quote">TEST</span>" ("<span class="quote">foo+</span>" "<span class="quote">bar+</span>" "<span class="quote">baz+</span>")))
        (anything-test-candidates
         '(((name . "<span class="quote">TEST</span>")
            (init
             . (lambda () (with-current-buffer (anything-candidate-buffer 'global)
                            (insert "<span class="quote">foo+\nbar+\nbaz+\n</span>"))))
            (candidates . anything-candidates-in-buffer)
            (match identity)
            (volatile)))))
      (expect '(("<span class="quote">TEST</span>" ("<span class="quote">foo+</span>" "<span class="quote">bar+</span>" "<span class="quote">baz+</span>")))
        (let (anything-candidate-number-limit)
          (anything-test-candidates
           '(((name . "<span class="quote">TEST</span>")
              (init
               . (lambda () (with-current-buffer (anything-candidate-buffer 'global)
                              (insert "<span class="quote">foo+\nbar+\nbaz+\n</span>"))))
              (candidates . anything-candidates-in-buffer)
              (match identity)
              (volatile))))))
      (expect '(("<span class="quote">TEST</span>" ("<span class="quote">foo+</span>")))
        (anything-test-candidates
         '(((name . "<span class="quote">TEST</span>")
            (init
             . (lambda () (with-current-buffer (anything-candidate-buffer 'global)
                            (insert "<span class="quote">foo+\nbar+\nbaz+\n</span>"))))
            (candidates . anything-candidates-in-buffer)
            (match identity)
            (volatile)))
         "<span class="quote">oo\\+</span>"))
      (desc "<span class="quote">search attribute</span>")
      (expect '(("<span class="quote">TEST</span>" ("<span class="quote">foo+</span>")))
        (anything-test-candidates
         '(((name . "<span class="quote">TEST</span>")
            (init
             . (lambda () (with-current-buffer (anything-candidate-buffer 'global)
                            (insert "<span class="quote">foo+\nbar+\nbaz+\nooo\n</span>"))))
            (search search-forward)
            (candidates . anything-candidates-in-buffer)
            (match identity)
            (volatile)))
         "<span class="quote">oo+</span>"))
      (expect '(("<span class="quote">TEST</span>" ("<span class="quote">foo+</span>" "<span class="quote">ooo</span>")))
        (anything-test-candidates
         '(((name . "<span class="quote">TEST</span>")
            (init
             . (lambda () (with-current-buffer (anything-candidate-buffer 'global)
                            (insert "<span class="quote">foo+\nbar+\nbaz+\nooo\n</span>"))))
            (search search-forward re-search-forward)
            (candidates . anything-candidates-in-buffer)
            (match identity)
            (volatile)))
         "<span class="quote">oo+</span>"))
      (expect '(("<span class="quote">TEST</span>" ("<span class="quote">foo+</span>" "<span class="quote">ooo</span>")))
        (anything-test-candidates
         '(((name . "<span class="quote">TEST</span>")
            (init
             . (lambda () (with-current-buffer (anything-candidate-buffer 'global)
                            (insert "<span class="quote">foo+\nbar+\nbaz+\nooo\n</span>"))))
            (search re-search-forward search-forward)
            (candidates . anything-candidates-in-buffer)
            (match identity)
            (volatile)))
         "<span class="quote">oo+</span>"))
      (expect '(("<span class="quote">TEST</span>" ("<span class="quote">ooo</span>" "<span class="quote">foo+</span>")))
        (anything-test-candidates
         '(((name . "<span class="quote">TEST</span>")
            (init
             . (lambda () (with-current-buffer (anything-candidate-buffer 'global)
                            (insert "<span class="quote">bar+\nbaz+\nooo\nfoo+\n</span>"))))
            (search re-search-forward search-forward)
            (candidates . anything-candidates-in-buffer)
            (match identity)
            (volatile)))
         "<span class="quote">oo+</span>"))
      <span class="linecomment">;; faster exact match</span>
      (expect '(("<span class="quote">TEST</span>" ("<span class="quote">bar+</span>")))
        (anything-test-candidates
         '(((name . "<span class="quote">TEST</span>")
            (init
             . (lambda () (with-current-buffer (anything-candidate-buffer 'global)
                            (insert "<span class="quote">bar+\nbaz+\nooo\nfoo+\n</span>"))))
            (search (lambda (pattern &rest _)
                      (and (search-forward (concat "<span class="quote">\n</span>" pattern "<span class="quote">\n</span>") nil t)
                           (forward-line -1))))
            (candidates . anything-candidates-in-buffer)
            (match identity)
            (volatile)))
         "<span class="quote">bar+</span>"))
      <span class="linecomment">;; faster prefix match</span>
      (expect '(("<span class="quote">TEST</span>" ("<span class="quote">bar+</span>")))
        (anything-test-candidates
         '(((name . "<span class="quote">TEST</span>")
            (init
             . (lambda () (with-current-buffer (anything-candidate-buffer 'global)
                            (insert "<span class="quote">bar+\nbaz+\nooo\nfoo+\n</span>"))))
            (search (lambda (pattern &rest _)
                      (search-forward (concat "<span class="quote">\n</span>" pattern) nil t)))
            (candidates . anything-candidates-in-buffer)
            (match identity)
            (volatile)))
         "<span class="quote">ba</span>"))
      (desc "<span class="quote">anything-current-buffer-is-modified</span>")
      (expect '(("<span class="quote">FOO</span>" ("<span class="quote">modified</span>")))
        (let ((sources '(((name . "<span class="quote">FOO</span>")
                          (candidates
                           . (lambda ()
                               (if (anything-current-buffer-is-modified)
                                   '("<span class="quote">modified</span>")
                                 '("<span class="quote">unmodified</span>"))))))))
          (with-temp-buffer
            (clrhash anything-tick-hash)
            (insert "<span class="quote">1</span>")
            (anything-test-candidates sources))))
      (expect '(("<span class="quote">FOO</span>" ("<span class="quote">unmodified</span>")))
        (let ((sources '(((name . "<span class="quote">FOO</span>")
                          (candidates
                           . (lambda ()
                               (if (anything-current-buffer-is-modified)
                                   '("<span class="quote">modified</span>")
                                 '("<span class="quote">unmodified</span>"))))))))
          (with-temp-buffer
            (clrhash anything-tick-hash)
            (insert "<span class="quote">1</span>")
            (anything-test-candidates sources)
            (anything-test-candidates sources))))
      (expect '(("<span class="quote">FOO</span>" ("<span class="quote">modified</span>")))
        (let ((sources '(((name . "<span class="quote">FOO</span>")
                          (candidates
                           . (lambda ()
                               (if (anything-current-buffer-is-modified)
                                   '("<span class="quote">modified</span>")
                                 '("<span class="quote">unmodified</span>"))))))))
          (with-temp-buffer
            (clrhash anything-tick-hash)
            (insert "<span class="quote">1</span>")
            (anything-test-candidates sources)
            (insert "<span class="quote">2</span>")
            (anything-test-candidates sources))))
      (expect '(("<span class="quote">BAR</span>" ("<span class="quote">modified</span>")))
        (let ((sources1 '(((name . "<span class="quote">FOO</span>")
                           (candidates
                            . (lambda ()
                                (if (anything-current-buffer-is-modified)
                                    '("<span class="quote">modified</span>")
                                  '("<span class="quote">unmodified</span>")))))))
              (sources2 '(((name . "<span class="quote">BAR</span>")
                           (candidates
                            . (lambda ()
                                (if (anything-current-buffer-is-modified)
                                    '("<span class="quote">modified</span>")
                                  '("<span class="quote">unmodified</span>"))))))))
          (with-temp-buffer
            (clrhash anything-tick-hash)
            (insert "<span class="quote">1</span>")
            (anything-test-candidates sources1)
            (anything-test-candidates sources2))))
      (expect '(("<span class="quote">FOO</span>" ("<span class="quote">unmodified</span>")))
        (let ((sources1 '(((name . "<span class="quote">FOO</span>")
                           (candidates
                            . (lambda ()
                                (if (anything-current-buffer-is-modified)
                                    '("<span class="quote">modified</span>")
                                  '("<span class="quote">unmodified</span>")))))))
              (sources2 '(((name . "<span class="quote">BAR</span>")
                           (candidates
                            . (lambda ()
                                (if (anything-current-buffer-is-modified)
                                    '("<span class="quote">modified</span>")
                                  '("<span class="quote">unmodified</span>"))))))))
          (with-temp-buffer
            (clrhash anything-tick-hash)
            (insert "<span class="quote">1</span>")
            (anything-test-candidates sources1)
            (anything-test-candidates sources2)
            (anything-test-candidates sources1))))
      (expect '(("<span class="quote">BAR</span>" ("<span class="quote">unmodified</span>")))
        (let ((sources1 '(((name . "<span class="quote">FOO</span>")
                           (candidates
                            . (lambda ()
                                (if (anything-current-buffer-is-modified)
                                    '("<span class="quote">modified</span>")
                                  '("<span class="quote">unmodified</span>")))))))
              (sources2 '(((name . "<span class="quote">BAR</span>")
                           (candidates
                            . (lambda ()
                                (if (anything-current-buffer-is-modified)
                                    '("<span class="quote">modified</span>")
                                  '("<span class="quote">unmodified</span>"))))))))
          (with-temp-buffer
            (clrhash anything-tick-hash)
            (insert "<span class="quote">1</span>")
            (anything-test-candidates sources1)
            (anything-test-candidates sources2)
            (anything-test-candidates sources2))))
      (expect '(("<span class="quote">BAR</span>" ("<span class="quote">modified</span>")))
        (let ((sources1 '(((name . "<span class="quote">FOO</span>")
                           (candidates
                            . (lambda ()
                                (if (anything-current-buffer-is-modified)
                                    '("<span class="quote">modified</span>")
                                  '("<span class="quote">unmodified</span>")))))))
              (sources2 '(((name . "<span class="quote">BAR</span>")
                           (candidates
                            . (lambda ()
                                (if (anything-current-buffer-is-modified)
                                    '("<span class="quote">modified</span>")
                                  '("<span class="quote">unmodified</span>"))))))))
          (with-temp-buffer
            (clrhash anything-tick-hash)
            (insert "<span class="quote">1</span>")
            (anything-test-candidates sources1)
            (anything-test-candidates sources2)
            (with-temp-buffer
              (anything-test-candidates sources2)))))
      (desc "<span class="quote">anything-source-name</span>")
      (expect "<span class="quote">FOO</span>"
        (let (v)
          (anything-test-candidates '(((name . "<span class="quote">FOO</span>")
                                       (init
                                        . (lambda () (setq v anything-source-name)))
                                       (candidates "<span class="quote">ok</span>"))))
          v))
      (expect "<span class="quote">FOO</span>"
        (let (v)
          (anything-test-candidates '(((name . "<span class="quote">FOO</span>")
                                       (candidates
                                        . (lambda ()
                                            (setq v anything-source-name)
                                            '("<span class="quote">ok</span>"))))))
          v))
      (expect "<span class="quote">FOO</span>"
        (let (v)
          (anything-test-candidates '(((name . "<span class="quote">FOO</span>")
                                       (candidates "<span class="quote">ok</span>")
                                       (candidate-transformer
                                        . (lambda (c)
                                            (setq v anything-source-name)
                                            c)))))
          v))
      (expect "<span class="quote">FOO</span>"
        (let (v)
          (anything-test-candidates '(((name . "<span class="quote">FOO</span>")
                                       (candidates "<span class="quote">ok</span>")
                                       (filtered-candidate-transformer
                                        . (lambda (c s)
                                            (setq v anything-source-name)
                                            c)))))
          v))
      (expect "<span class="quote">FOO</span>"
        (let (v)
          (anything-test-candidates '(((name . "<span class="quote">FOO</span>")
                                       (candidates "<span class="quote">ok</span>")
                                       (display-to-real
                                        . (lambda (c)
                                            (setq v anything-source-name)
                                            c))
                                       (action . identity))))
          (anything-execute-selection-action)
          v))
      (desc "<span class="quote">anything-candidate-buffer create</span>")
      (expect "<span class="quote"> *anything candidates:FOO*</span>"
        (let* (anything-candidate-buffer-alist
               (anything-source-name "<span class="quote">FOO</span>")
               (buf (anything-candidate-buffer 'global)))
          (prog1 (buffer-name buf)
            (kill-buffer buf))))
      (expect "<span class="quote"> *anything candidates:FOO*aTestBuffer</span>"
        (let* (anything-candidate-buffer-alist
               (anything-source-name "<span class="quote">FOO</span>")
               (anything-current-buffer (get-buffer-create "<span class="quote">aTestBuffer</span>"))
               (buf (anything-candidate-buffer 'local)))
          (prog1 (buffer-name buf)
            (kill-buffer anything-current-buffer)
            (kill-buffer buf))))
      (expect 0
        (let (anything-candidate-buffer-alist
              (anything-source-name "<span class="quote">FOO</span>") buf)
          (with-current-buffer  (anything-candidate-buffer 'global)
            (insert "<span class="quote">1</span>"))
          (setq buf  (anything-candidate-buffer 'global))
          (prog1 (buffer-size buf)
            (kill-buffer buf))))
      (desc "<span class="quote">anything-candidate-buffer get-buffer</span>")
      (expect "<span class="quote"> *anything candidates:FOO*</span>"
        (let* (anything-candidate-buffer-alist
               (anything-source-name "<span class="quote">FOO</span>")
               (buf (anything-candidate-buffer 'global)))
          (prog1 (buffer-name (anything-candidate-buffer))
            (kill-buffer buf))))
      (expect "<span class="quote"> *anything candidates:FOO*aTestBuffer</span>"
        (let* (anything-candidate-buffer-alist
               (anything-source-name "<span class="quote">FOO</span>")
               (anything-current-buffer (get-buffer-create "<span class="quote">aTestBuffer</span>"))
               (buf (anything-candidate-buffer 'local)))
          (prog1 (buffer-name (anything-candidate-buffer))
            (kill-buffer anything-current-buffer)
            (kill-buffer buf))))
      (expect "<span class="quote"> *anything candidates:FOO*</span>"
        (let* (anything-candidate-buffer-alist
               (anything-source-name "<span class="quote">FOO</span>")
               (buf-local (anything-candidate-buffer 'local))
               (buf-global (anything-candidate-buffer 'global)))
          (prog1 (buffer-name (anything-candidate-buffer))
            (kill-buffer buf-local)
            (kill-buffer buf-global))))
      (expect "<span class="quote"> *anything candidates:FOO*aTestBuffer</span>"
        (let* (anything-candidate-buffer-alist
               (anything-source-name "<span class="quote">FOO</span>")
               (anything-current-buffer (get-buffer-create "<span class="quote">aTestBuffer</span>"))
               (buf-global (anything-candidate-buffer 'global))
               (buf-local (anything-candidate-buffer 'local)))
          (prog1 (buffer-name (anything-candidate-buffer))
            (kill-buffer buf-local)
            (kill-buffer buf-global))))
      (expect nil
        (let* (anything-candidate-buffer-alist
               (anything-source-name "<span class="quote">NOP__</span>"))
          (anything-candidate-buffer)))
      (desc "<span class="quote">anything-candidate-buffer register-buffer</span>")
      (expect "<span class="quote"> *anything test candidates*</span>"
        (let (anything-candidate-buffer-alist
              (buf (get-buffer-create "<span class="quote"> *anything test candidates*</span>")))
          (with-current-buffer buf
            (insert "<span class="quote">1\n2\n</span>")
            (prog1 (buffer-name (anything-candidate-buffer buf))
              (kill-buffer (current-buffer))))))
      (expect "<span class="quote"> *anything test candidates*</span>"
        (let (anything-candidate-buffer-alist
              (buf (get-buffer-create "<span class="quote"> *anything test candidates*</span>")))
          (with-current-buffer buf
            (insert "<span class="quote">1\n2\n</span>")
            (anything-candidate-buffer buf)
            (prog1 (buffer-name (anything-candidate-buffer))
              (kill-buffer (current-buffer))))))
      (expect "<span class="quote">1\n2\n</span>"
        (let (anything-candidate-buffer-alist
              (buf (get-buffer-create "<span class="quote"> *anything test candidates*</span>")))
          (with-current-buffer buf
            (insert "<span class="quote">1\n2\n</span>")
            (anything-candidate-buffer buf)
            (prog1 (buffer-string)
              (kill-buffer (current-buffer))))))
      (expect "<span class="quote">buf1</span>"
        (let (anything-candidate-buffer-alist
              (anything-source-name "<span class="quote">foo</span>")
              (buf1 (get-buffer-create "<span class="quote">buf1</span>"))
              (buf2 (get-buffer-create "<span class="quote">buf2</span>")))
          (anything-candidate-buffer buf1)
          (anything-candidate-buffer buf2)
          (prog1 (buffer-name (anything-candidate-buffer buf1))
            (kill-buffer buf1)
            (kill-buffer buf2))))
      (desc "<span class="quote">action attribute</span>")
      (expect "<span class="quote">foo</span>"
        (anything-test-candidates
         '(((name . "<span class="quote">TEST</span>")
            (candidates "<span class="quote">foo</span>")
            (action ("<span class="quote">identity</span>" . identity)))))
        (anything-execute-selection-action))
      (expect "<span class="quote">foo</span>"
        (anything-test-candidates
         '(((name . "<span class="quote">TEST</span>")
            (candidates "<span class="quote">foo</span>")
            (action ("<span class="quote">identity</span>" . (lambda (c) (identity c)))))))
        (anything-execute-selection-action))
      (desc "<span class="quote">anything-execute-selection-action</span>")
      (expect "<span class="quote">FOO</span>"
        (anything-execute-selection-action
         "<span class="quote">foo</span>" '(("<span class="quote">upcase</span>" . upcase))  nil #'identity))
      (expect "<span class="quote">FOO</span>"
        (anything-execute-selection-action
         "<span class="quote">foo</span>" '(("<span class="quote">upcase</span>" . (lambda (c) (upcase c)))) nil #'identity))
      (desc "<span class="quote">display-to-real attribute</span>")
      (expect "<span class="quote">FOO</span>"
        (anything-execute-selection-action
         "<span class="quote">foo</span>"
         '(("<span class="quote">identity</span>" . identity))
         nil
         #'upcase
         ))
      (expect "<span class="quote">FOO</span>"
        (anything-test-candidates
         '(((name . "<span class="quote">TEST</span>")
            (candidates "<span class="quote">foo</span>")
            (display-to-real . upcase)
            (action ("<span class="quote">identity</span>" . identity)))))
        (anything-execute-selection-action))
      (desc "<span class="quote">cleanup test</span>")
      (expect 'cleaned
        (let (v)
          (anything-test-candidates
           '(((name . "<span class="quote">TEST</span>")
              (cleanup . (lambda () (setq v 'cleaned))))))
          v))
      (desc "<span class="quote">anything-get-current-source</span>")
      <span class="linecomment">;; in init/candidates/action/candidate-transformer/filtered-candidate-transformer</span>
      <span class="linecomment">;; display-to-real/cleanup function</span>
      (expect "<span class="quote">FOO</span>"
        (assoc-default
         'name
         (anything-funcall-with-source '((name . "<span class="quote">FOO</span>")) 'anything-get-current-source)))
      <span class="linecomment">;; init</span>
      (expect "<span class="quote">FOO</span>"
        (let (v)
          (anything-test-candidates
           '(((name . "<span class="quote">FOO</span>")
              (init . (lambda () (setq v (anything-get-current-source)))))))
          (assoc-default 'name v)))
      <span class="linecomment">;; candidates</span>
      (expect "<span class="quote">FOO</span>"
        (let (v)
          (anything-test-candidates
           '(((name . "<span class="quote">FOO</span>")
              (candidates . (lambda () (setq v (anything-get-current-source)) '("<span class="quote">a</span>"))))))
          (assoc-default 'name v)))
      <span class="linecomment">;; action</span>
      (expect "<span class="quote">FOO</span>"
        (let (v)
          (anything-test-candidates
           '(((name . "<span class="quote">FOO</span>")
              (candidates "<span class="quote">a</span>")
              (action
               . (lambda (c) (setq v (anything-get-current-source)) c)))))
          (anything-execute-selection-action)
          (assoc-default 'name v)))
      <span class="linecomment">;; candidate-transformer</span>
      (expect "<span class="quote">FOO</span>"
        (let (v)
          (anything-test-candidates
           '(((name . "<span class="quote">FOO</span>")
              (candidates "<span class="quote">a</span>")
              (candidate-transformer
               . (lambda (c) (setq v (anything-get-current-source)) c)))))
          (assoc-default 'name v)))
      <span class="linecomment">;; filtered-candidate-transformer</span>
      (expect "<span class="quote">FOO</span>"
        (let (v)
          (anything-test-candidates
           '(((name . "<span class="quote">FOO</span>")
              (candidates "<span class="quote">a</span>")
              (filtered-candidate-transformer
               . (lambda (c s) (setq v (anything-get-current-source)) c)))))
          (assoc-default 'name v)))
      <span class="linecomment">;; action-transformer</span>
      (expect "<span class="quote">FOO</span>"
        (let (v)
          (anything-test-candidates
           '(((name . "<span class="quote">FOO</span>")
              (candidates "<span class="quote">a</span>")
              (action-transformer
               . (lambda (a c) (setq v (anything-get-current-source)) a))
              (action . identity))))
          (anything-execute-selection-action)
          (assoc-default 'name v)))
      <span class="linecomment">;; display-to-real</span>
      (expect "<span class="quote">FOO</span>"
        (let (v)
          (anything-test-candidates
           '(((name . "<span class="quote">FOO</span>")
              (init . (lambda () (with-current-buffer (anything-candidate-buffer 'global)
                                   (insert "<span class="quote">a\n</span>"))))
              (candidates-in-buffer)
              (display-to-real
               . (lambda (c) (setq v (anything-get-current-source)) c))
              (action . identity))))
          (anything-execute-selection-action)
          (assoc-default 'name v)))
      <span class="linecomment">;; cleanup</span>
      (expect "<span class="quote">FOO</span>"
        (let (v)
          (anything-test-candidates
           '(((name . "<span class="quote">FOO</span>")
              (candidates "<span class="quote">a</span>")
              (cleanup
               . (lambda () (setq v (anything-get-current-source)))))))
          (assoc-default 'name v)))
      <span class="linecomment">;; candidates are displayed</span>
      (expect "<span class="quote">TEST</span>"
        (anything-test-candidates
         '(((name . "<span class="quote">TEST</span>")
            (candidates "<span class="quote">foo</span>")
            (action ("<span class="quote">identity</span>" . identity)))))
        (assoc-default 'name (anything-get-current-source)))
      (desc "<span class="quote">anything-attr</span>")
      (expect "<span class="quote">FOO</span>"
        (anything-funcall-with-source
         '((name . "<span class="quote">FOO</span>"))
         (lambda ()
           (anything-attr 'name))))
      (expect 'fuga
        (let (v)
          (anything-test-candidates
           '(((name . "<span class="quote">FOO</span>")
              (hoge . fuga)
              (init . (lambda () (setq v (anything-attr 'hoge))))
              (candidates "<span class="quote">a</span>"))))
          v))
      (expect nil
        (let (v)
          (anything-test-candidates
           '(((name . "<span class="quote">FOO</span>")
              (init . (lambda () (setq v (anything-attr 'hoge))))
              (candidates "<span class="quote">a</span>"))))
          v))
      (expect nil
        (let (v)
          (anything-test-candidates
           '(((name . "<span class="quote">FOO</span>")
              (hoge)                    <span class="linecomment">;INCOMPATIBLE!</span>
              (init . (lambda () (setq v (anything-attr 'hoge))))
              (candidates "<span class="quote">a</span>"))))
          v))
      (desc "<span class="quote">anything-attr-defined</span>")
      (expect (non-nil)
        (let (v)
          (anything-test-candidates
           '(((name . "<span class="quote">FOO</span>")
              (hoge)
              (init . (lambda () (setq v (anything-attr-defined 'hoge))))
              (candidates "<span class="quote">a</span>"))))
          v))      
      (expect nil
        (let (v)
          (anything-test-candidates
           '(((name . "<span class="quote">FOO</span>")
              (init . (lambda () (setq v (anything-attr-defined 'hoge))))
              (candidates "<span class="quote">a</span>"))))
          v))      
      (desc "<span class="quote">anything-attrset</span>")
      (expect '((name . "<span class="quote">FOO</span>") (hoge . 77))
        (let ((src '((name . "<span class="quote">FOO</span>") (hoge))))
          (anything-attrset 'hoge 77 src)
          src))
      (expect 77
        (anything-attrset 'hoge 77 '((name . "<span class="quote">FOO</span>") (hoge))))

      (expect '((name . "<span class="quote">FOO</span>") (hoge . 77))
        (let ((src '((name . "<span class="quote">FOO</span>") (hoge . 1))))
          (anything-attrset 'hoge 77 src)
          src))

      (expect '((name . "<span class="quote">FOO</span>") (hoge . 77) (x))
        (let ((src '((name . "<span class="quote">FOO</span>") (x))))
          (anything-attrset 'hoge 77 src)
          src))
      (expect 77
        (anything-attrset 'hoge 77 '((name . "<span class="quote">FOO</span>"))))
      (desc "<span class="quote">anything-preselect</span>")
      <span class="linecomment">;; entire candidate</span>
      (expect "<span class="quote">foo</span>"
        (with-current-buffer (anything-create-anything-buffer t)
          (let ((anything-pattern "<span class="quote"></span>")
                (anything-test-mode t))
            (anything-process-source '((name . "<span class="quote">test</span>")
                                       (candidates "<span class="quote">hoge</span>" "<span class="quote">foo</span>" "<span class="quote">bar</span>")))
            (anything-preselect "<span class="quote">foo</span>")
            (anything-get-selection))))
      <span class="linecomment">;; regexp</span>
      (expect "<span class="quote">foo</span>"
        (with-current-buffer (anything-create-anything-buffer t)
          (let ((anything-pattern "<span class="quote"></span>")
                (anything-test-mode t))
            (anything-process-source '((name . "<span class="quote">test</span>")
                                       (candidates "<span class="quote">hoge</span>" "<span class="quote">foo</span>" "<span class="quote">bar</span>")))
            (anything-preselect "<span class="quote">fo+</span>")
            (anything-get-selection))))
      <span class="linecomment">;; no match -&gt; first entry</span>
      (expect "<span class="quote">hoge</span>"
        (with-current-buffer (anything-create-anything-buffer t)
          (let ((anything-pattern "<span class="quote"></span>")
                (anything-test-mode t))
            (anything-process-source '((name . "<span class="quote">test</span>")
                                       (candidates "<span class="quote">hoge</span>" "<span class="quote">foo</span>" "<span class="quote">bar</span>")))
            (anything-preselect "<span class="quote">not found</span>")
            (anything-get-selection))))
      (desc "<span class="quote">anything-check-new-input</span>")
      (expect "<span class="quote">newpattern</span>"
        (stub anything-update)
        (stub anything-action-window)
        (let ((anything-pattern "<span class="quote">pattern</span>"))
          (anything-check-new-input "<span class="quote">newpattern</span>")
          anything-pattern))
      <span class="linecomment">;; anything-input == nil when action window is available</span>
      (expect nil
        (stub anything-update)
        (stub anything-action-window =&gt; t)
        (let ((anything-pattern "<span class="quote">pattern</span>")
              anything-input)
          (anything-check-new-input "<span class="quote">newpattern</span>")
          anything-input))
      <span class="linecomment">;; anything-input == anything-pattern unless action window is available</span>
      (expect "<span class="quote">newpattern</span>"
        (stub anything-update)
        (stub anything-action-window =&gt; nil)
        (let ((anything-pattern "<span class="quote">pattern</span>")
              anything-input)
          (anything-check-new-input "<span class="quote">newpattern</span>")
          anything-input))
      (expect (mock (anything-update))
        (stub anything-action-window)
        (let (anything-pattern)
          (anything-check-new-input "<span class="quote">foo</span>")))
      (desc "<span class="quote">anything-update</span>")
      (expect (mock (anything-process-source '((name . "<span class="quote">1</span>"))))
        (anything-test-update '(((name . "<span class="quote">1</span>"))) "<span class="quote"></span>"))
      <span class="linecomment">;; (find-function 'anything-update)</span>
      <span class="linecomment">;; TODO el-mock.el should express 2nd call of function.</span>
      <span class="linecomment">;;     (expect (mock (anything-process-source '((name . "2"))))</span>
      <span class="linecomment">;;       (stub anything-get-sources =&gt; '(((name . "1")) ((name . "2"))))</span>
      <span class="linecomment">;;       (stub run-hooks)</span>
      <span class="linecomment">;;       (stub anything-maybe-fit-frame)</span>
      <span class="linecomment">;;       (stub run-with-idle-timer)</span>
      <span class="linecomment">;;       (anything-update))</span>
      (expect (mock (run-with-idle-timer * nil 'anything-process-delayed-sources
                                         '(((name . "<span class="quote">2</span>") (delayed)))))
        (stub anything-get-sources =&gt; '(((name . "<span class="quote">1</span>"))
                                        ((name . "<span class="quote">2</span>") (delayed))))
        (stub run-hooks)
        (stub anything-maybe-fit-frame)
        (let ((anything-pattern "<span class="quote"></span>") anything-test-mode)
          (anything-update)))

      (expect (mock (run-with-idle-timer * nil 'anything-process-delayed-sources nil))
        (stub anything-get-sources =&gt; '(((name . "<span class="quote">1</span>"))
                                        ((name . "<span class="quote">2</span>"))))
        (stub run-hooks)
        (stub anything-maybe-fit-frame)
        (let ((anything-pattern "<span class="quote"></span>") anything-test-mode)
          (anything-update)))


      (desc "<span class="quote">requires-pattern attribute</span>")
      (expect (not-called anything-process-source)
        (anything-test-update '(((name . "<span class="quote">1</span>") (requires-pattern))) "<span class="quote"></span>"))
      (expect (not-called anything-process-source)
        (anything-test-update '(((name . "<span class="quote">1</span>") (requires-pattern . 3))) "<span class="quote">xx</span>"))

      (desc "<span class="quote">delay</span>")
      (expect (mock (sit-for 0.25))
        (stub with-current-buffer)
        (let ((anything-idle-delay 1.0)
              (anything-input-idle-delay 0.75))
          (anything-process-delayed-sources t)))
      (expect (mock (sit-for 0.0))
        (stub with-current-buffer)
        (let ((anything-idle-delay 0.2)
              (anything-input-idle-delay 0.5))
          (anything-process-delayed-sources t)))    
      (expect (mock (sit-for 0.5))
        (stub with-current-buffer)
        (let ((anything-idle-delay 0.5)
              (anything-input-idle-delay nil))
          (anything-process-delayed-sources t)))
      (desc "<span class="quote">anything-normalize-sources</span>")
      (expect '(anything-c-source-test)
        (anything-normalize-sources 'anything-c-source-test))
      (expect '(anything-c-source-test)
        (anything-normalize-sources '(anything-c-source-test)))
      (expect '(anything-c-source-test)
        (let ((anything-sources '(anything-c-source-test)))
          (anything-normalize-sources nil)))
      (desc "<span class="quote">anything-get-action</span>")
      (expect '(("<span class="quote">identity</span>" . identity))
        (stub buffer-size =&gt; 1)
        (stub anything-get-current-source =&gt; '((name . "<span class="quote">test</span>")
                                               (action ("<span class="quote">identity</span>" . identity))))
        (anything-get-action))
      (expect '((("<span class="quote">identity</span>" . identity)) "<span class="quote">action-transformer is called</span>")
        (stub buffer-size =&gt; 1)
        (stub anything-get-current-source
              =&gt; '((name . "<span class="quote">test</span>")
                   (action ("<span class="quote">identity</span>" . identity))
                   (action-transformer
                    . (lambda (actions selection)
                        (list actions selection)))))
        (stub anything-get-selection =&gt; "<span class="quote">action-transformer is called</span>")
        (anything-get-action))
      (desc "<span class="quote">anything-select-nth-action</span>")
      (expect "<span class="quote">selection</span>"
        (stub anything-get-selection =&gt; "<span class="quote">selection</span>")
        (stub anything-exit-minibuffer)
        (let (anything-saved-selection)
          (anything-select-nth-action 1)
          anything-saved-selection))
      (expect 'cadr
        (stub anything-get-action =&gt; '(("<span class="quote">0</span>" . car) ("<span class="quote">1</span>" . cdr) ("<span class="quote">2</span>" . cadr)))
        (stub anything-exit-minibuffer)
        (stub anything-get-selection =&gt; "<span class="quote">selection</span>")
        (let (anything-saved-action)
          (anything-select-nth-action 2)
          anything-saved-action))
      (desc "<span class="quote">anything-funcall-foreach</span>")
      (expect (mock (upcase "<span class="quote">foo</span>"))
        (stub anything-get-sources =&gt; '(((init . (lambda () (upcase "<span class="quote">foo</span>"))))))
        (anything-funcall-foreach 'init))
      (expect (mock (downcase "<span class="quote">bar</span>"))
        (stub anything-get-sources =&gt; '(((init . (lambda () (upcase "<span class="quote">foo</span>"))))
                                        ((init . (lambda () (downcase "<span class="quote">bar</span>"))))))
        (anything-funcall-foreach 'init))
      (expect (not-called anything-funcall-with-source)
        (stub anything-get-sources =&gt; '(((init . (lambda () (upcase "<span class="quote">foo</span>"))))))
        (anything-funcall-foreach 'not-found))
      <span class="linecomment">;; TODO anything-select-with-digit-shortcut test</span>
      (desc "<span class="quote">anything-get-cached-candidates</span>")
      (expect '("<span class="quote">cached</span>" "<span class="quote">version</span>")
        (let ((anything-candidate-cache '(("<span class="quote">test</span>" "<span class="quote">cached</span>" "<span class="quote">version</span>"))))
          (anything-get-cached-candidates '((name . "<span class="quote">test</span>")
                                            (candidates "<span class="quote">new</span>")))))
      (expect '("<span class="quote">new</span>")
        (let ((anything-candidate-cache '(("<span class="quote">other</span>" "<span class="quote">cached</span>" "<span class="quote">version</span>"))))
          (anything-get-cached-candidates '((name . "<span class="quote">test</span>")
                                            (candidates "<span class="quote">new</span>")))))
      (expect '(("<span class="quote">test</span>" "<span class="quote">new</span>")
                ("<span class="quote">other</span>" "<span class="quote">cached</span>" "<span class="quote">version</span>"))
        (let ((anything-candidate-cache '(("<span class="quote">other</span>" "<span class="quote">cached</span>" "<span class="quote">version</span>"))))
          (anything-get-cached-candidates '((name . "<span class="quote">test</span>")
                                            (candidates "<span class="quote">new</span>")))
          anything-candidate-cache))
      (expect '(("<span class="quote">other</span>" "<span class="quote">cached</span>" "<span class="quote">version</span>"))
        (let ((anything-candidate-cache '(("<span class="quote">other</span>" "<span class="quote">cached</span>" "<span class="quote">version</span>"))))
          (anything-get-cached-candidates '((name . "<span class="quote">test</span>")
                                            (candidates "<span class="quote">new</span>")
                                            (volatile)))
          anything-candidate-cache))
      <span class="linecomment">;; TODO when candidates == process</span>
      <span class="linecomment">;; TODO anything-output-filter</span>
      (desc "<span class="quote">candidate-number-limit attribute</span>")
      (expect '("<span class="quote">a</span>" "<span class="quote">b</span>")
        (let ((anything-pattern "<span class="quote"></span>")
              (anything-candidate-number-limit 20))
          (anything-compute-matches '((name . "<span class="quote">FOO</span>") (candidates "<span class="quote">a</span>" "<span class="quote">b</span>" "<span class="quote">c</span>")
                                      (candidate-number-limit . 2) (volatile)))))
      (expect '("<span class="quote">a</span>" "<span class="quote">b</span>")
        (let ((anything-pattern "<span class="quote">[abc]</span>")
              (anything-candidate-number-limit 20))
          (anything-compute-matches '((name . "<span class="quote">FOO</span>") (candidates "<span class="quote">a</span>" "<span class="quote">b</span>" "<span class="quote">c</span>")
                                      (candidate-number-limit . 2) (volatile)))))
      (expect '(("<span class="quote">TEST</span>" ("<span class="quote">a</span>" "<span class="quote">b</span>" "<span class="quote">c</span>")))
        (let ((anything-candidate-number-limit 2))
          (anything-test-candidates
           '(((name . "<span class="quote">TEST</span>")
              (init
               . (lambda () (with-current-buffer (anything-candidate-buffer 'global)
                              (insert "<span class="quote">a\nb\nc\nd\n</span>"))))
              (candidates . anything-candidates-in-buffer)
              (match identity)
              (candidate-number-limit . 3)
              (volatile))))))
      (expect '(("<span class="quote">TEST</span>" ("<span class="quote">a</span>" "<span class="quote">b</span>" "<span class="quote">c</span>")))
        (let ((anything-candidate-number-limit 2))
          (anything-test-candidates
           '(((name . "<span class="quote">TEST</span>")
              (init
               . (lambda () (with-current-buffer (anything-candidate-buffer 'global)
                              (insert "<span class="quote">a\nb\nc\nd\n</span>"))))
              (candidates . anything-candidates-in-buffer)
              (match identity)
              (candidate-number-limit . 3)
              (volatile)))
           "<span class="quote">.</span>")))
      (desc "<span class="quote">multiple init</span>")
      (expect '(1 . 2)
        (let (a b)
          (anything-test-candidates
           '(((name . "<span class="quote">test</span>")
              (init (lambda () (setq a 1))
                    (lambda () (setq b 2))))))
          (cons a b)))
      (expect 1
        (let (a)
          (anything-test-candidates
           '(((name . "<span class="quote">test</span>")
              (init (lambda () (setq a 1))))))
          a))
      (desc "<span class="quote">multiple cleanup</span>")
      (expect '(1 . 2)
        (let (a b)
          (anything-test-candidates
           '(((name . "<span class="quote">test</span>")
              (cleanup (lambda () (setq a 1))
                       (lambda () (setq b 2))))))
          (cons a b)))
      (desc "<span class="quote">anything-mklist</span>")
      (expect '(1)
        (anything-mklist 1))
      (expect '(2)
        (anything-mklist '(2)))
      (desc "<span class="quote">anything-before-initialize-hook</span>")
      (expect 'called
        (let ((anything-before-initialize-hook '((lambda () (setq v 'called))))
              v)
          (anything-initialize)
          v))
      (desc "<span class="quote">anything-after-initialize-hook</span>")
      (expect '(b a)
        (let ((anything-before-initialize-hook
               '((lambda () (setq v '(a)))))
              (anything-after-initialize-hook
               '((lambda () (setq v (cons 'b v)))))
              v)
          (anything-initialize)
          v))
      (expect 0
        (let ((anything-after-initialize-hook
               '((lambda () (setq v (buffer-size (get-buffer anything-buffer))))))
              v)
          (anything-initialize)
          v))
      (desc "<span class="quote">get-line attribute</span>")
      (expect '(("<span class="quote">TEST</span>" ("<span class="quote">FOO+</span>")))
        (anything-test-candidates
         '(((name . "<span class="quote">TEST</span>")
            (init
             . (lambda () (with-current-buffer (anything-candidate-buffer 'global)
                            (insert "<span class="quote">foo+\nbar+\nbaz+\n</span>"))))
            (candidates-in-buffer)
            (get-line . (lambda (s e) (upcase (buffer-substring-no-properties s e))))))
         "<span class="quote">oo\\+</span>"))
      (desc "<span class="quote">with-anything-restore-variables</span>")
      (expect '(7 8)
        (let ((a 7) (b 8)
              (anything-restored-variables '(a b)))
          (with-anything-restore-variables
            (setq a 0 b 0))
          (list a b)))
      (desc "<span class="quote">anything-cleanup-hook</span>")
      (expect 'called
        (let ((anything-cleanup-hook
               '((lambda () (setq v 'called))))
              v)
          (anything-cleanup)
          v))
      (desc "<span class="quote">with-anything-display-same-window</span>")
      (expect (non-nil)
        (save-window-excursion
          (delete-other-windows)
          (split-window)
          
          (let ((buf (get-buffer-create "<span class="quote"> tmp</span>"))
                (win (selected-window)))
            (with-anything-display-same-window
              (display-buffer buf)
              (eq win (get-buffer-window buf))))))
      (expect (non-nil)
        (save-window-excursion
          (delete-other-windows)
          (split-window)
          
          (let ((buf (get-buffer-create "<span class="quote"> tmp</span>"))
                (win (selected-window)))
            (with-anything-display-same-window
              (pop-to-buffer buf)
              (eq win (get-buffer-window buf))))))
      (expect (non-nil)
        (save-window-excursion
          (delete-other-windows)
          (split-window)
          
          (let ((buf (get-buffer-create "<span class="quote"> tmp</span>"))
                (win (selected-window)))
            (with-anything-display-same-window
              (switch-to-buffer buf)
              (eq win (get-buffer-window buf))))))
      (expect (non-nil)
        (save-window-excursion
          (delete-other-windows)
          (let ((buf (get-buffer-create "<span class="quote"> tmp</span>"))
                (win (selected-window)))
            (with-anything-display-same-window
              (display-buffer buf)
              (eq win (get-buffer-window buf))))))
      (expect (non-nil)
        (save-window-excursion
          (delete-other-windows)
          (let ((buf (get-buffer-create "<span class="quote"> tmp</span>"))
                (win (selected-window)))
            (with-anything-display-same-window
              (pop-to-buffer buf)
              (eq win (get-buffer-window buf))))))
      (desc "<span class="quote">search-from-end attribute</span>")
      (expect '(("<span class="quote">TEST</span>" ("<span class="quote">baz+</span>" "<span class="quote">bar+</span>" "<span class="quote">foo+</span>")))
        (anything-test-candidates
         '(((name . "<span class="quote">TEST</span>")
            (init
             . (lambda () (with-current-buffer (anything-candidate-buffer 'global)
                            (insert "<span class="quote">foo+\nbar+\nbaz+\n</span>"))))
            (candidates-in-buffer)
            (search-from-end)))))
      (expect '(("<span class="quote">TEST</span>" ("<span class="quote">baz+</span>" "<span class="quote">bar+</span>" "<span class="quote">foo+</span>")))
        (anything-test-candidates
         '(((name . "<span class="quote">TEST</span>")
            (init
             . (lambda () (with-current-buffer (anything-candidate-buffer 'global)
                            (insert "<span class="quote">foo+\nbar+\nbaz+\n</span>"))))
            (candidates-in-buffer)
            (search-from-end)))
         "<span class="quote">\\+</span>"))
      (expect '(("<span class="quote">TEST</span>" ("<span class="quote">baz+</span>" "<span class="quote">bar+</span>")))
        (anything-test-candidates
         '(((name . "<span class="quote">TEST</span>")
            (init
             . (lambda () (with-current-buffer (anything-candidate-buffer 'global)
                            (insert "<span class="quote">foo+\nbar+\nbaz+\n</span>"))))
            (candidates-in-buffer)
            (search-from-end)
            (candidate-number-limit . 2)))))
      (expect '(("<span class="quote">TEST</span>" ("<span class="quote">baz+</span>" "<span class="quote">bar+</span>")))
        (anything-test-candidates
         '(((name . "<span class="quote">TEST</span>")
            (init
             . (lambda () (with-current-buffer (anything-candidate-buffer 'global)
                            (insert "<span class="quote">foo+\nbar+\nbaz+\n</span>"))))
            (candidates-in-buffer)
            (search-from-end)
            (candidate-number-limit . 2)))
         "<span class="quote">\\+</span>"))

      (desc "<span class="quote">header-name attribute</span>")
      (expect "<span class="quote">original is transformed</span>"
        (anything-test-update '(((name . "<span class="quote">original</span>")
                                 (candidates "<span class="quote">1</span>")
                                 (header-name
                                  . (lambda (name)
                                      (format "<span class="quote">%s is transformed</span>" name)))))
                              "<span class="quote"></span>")
        (with-current-buffer (anything-buffer-get)
          (buffer-string)
          (overlay-get (car (overlays-at (1+(point-min)))) 'display)))
      (desc "<span class="quote">volatile and match attribute</span>")
      <span class="linecomment">;; candidates function is called once per `anything-process-delayed-sources'</span>
      (expect 1
        (let ((v 0))
          (anything-test-candidates '(((name . "<span class="quote">test</span>")
                                       (candidates . (lambda () (incf v) '("<span class="quote">ok</span>")))
                                       (volatile)
                                       (match identity identity identity)))
                                    "<span class="quote">o</span>")
          v))
      (desc "<span class="quote">accept-empty attribute</span>")
      (expect nil
        (anything-test-candidates
         '(((name . "<span class="quote">test</span>") (candidates "<span class="quote"></span>") (action . identity))))
        (anything-execute-selection-action))
      (expect "<span class="quote"></span>"
        (anything-test-candidates
         '(((name . "<span class="quote">test</span>") (candidates "<span class="quote"></span>") (action . identity) (accept-empty))))
        (anything-execute-selection-action))
      (desc "<span class="quote">anything-tick-hash</span>")
      (expect nil
        (with-current-buffer (get-buffer-create "<span class="quote"> *00create+*</span>")
          (puthash "<span class="quote"> *00create+*/xxx</span>" 1 anything-tick-hash)
          (kill-buffer (current-buffer)))
        (gethash "<span class="quote"> *00create+*/xxx</span>" anything-tick-hash))
      (desc "<span class="quote">anything-execute-action-at-once-if-once</span>")
      (expect "<span class="quote">HOGE</span>"
        (let ((anything-execute-action-at-once-if-one t))
          (anything '(((name . "<span class="quote">one test1</span>")
                       (candidates "<span class="quote">hoge</span>")
                       (action . upcase))))))
      (expect "<span class="quote">ANY</span>"
        (let ((anything-execute-action-at-once-if-one t))
          (anything '(((name . "<span class="quote">one test2</span>")
                       (candidates "<span class="quote">hoge</span>" "<span class="quote">any</span>")
                       (action . upcase)))
                    "<span class="quote">an</span>")))
      <span class="linecomment">;; candidates &gt; 1</span>
      (expect (mock (read-string "<span class="quote">word: </span>" nil))
        (let ((anything-execute-action-at-once-if-one t))
          (anything '(((name . "<span class="quote">one test3</span>")
                       (candidates "<span class="quote">hoge</span>" "<span class="quote">foo</span>" "<span class="quote">bar</span>")
                       (action . identity)))
                    nil "<span class="quote">word: </span>")))
      (desc "<span class="quote">anything-quit-if-no-candidate</span>")
      (expect nil
        (let ((anything-quit-if-no-candidate t))
          (anything '(((name . "<span class="quote">zero test1</span>") (candidates) (action . upcase))))))
      (expect 'called
        (let (v (anything-quit-if-no-candidate (lambda () (setq v 'called))))
          (anything '(((name . "<span class="quote">zero test2</span>") (candidates) (action . upcase))))
          v))
      (desc "<span class="quote">real-to-display attribute</span>")
      (expect '(("<span class="quote">test</span>" ("<span class="quote">ddd</span>")))
        (anything-test-candidates '(((name . "<span class="quote">test</span>")
                                     (candidates "<span class="quote">ddd</span>")
                                     (real-to-display . upcase)
                                     (action . identity)))))
      (expect "<span class="quote">test\nDDD\n</span>"
        (anything-test-update '(((name . "<span class="quote">test</span>")
                                 (candidates "<span class="quote">ddd</span>")
                                 (real-to-display . upcase)
                                 (action . identity)))
                              "<span class="quote"></span>")
        (with-current-buffer (anything-buffer-get) (buffer-string)))
      (desc "<span class="quote">real-to-display and candidates-in-buffer</span>")
      (expect '(("<span class="quote">test</span>" ("<span class="quote">a</span>" "<span class="quote">b</span>")))
        (anything-test-candidates
         '(((name . "<span class="quote">test</span>")
            (init
             . (lambda () (with-current-buffer (anything-candidate-buffer 'global)
                            (erase-buffer)
                            (insert "<span class="quote">a\nb\n</span>"))))
            (candidates-in-buffer)
            (real-to-display . upcase)
            (action . identity)))))
      (expect "<span class="quote">test\nA\nB\n</span>"
        (stub read-string)
        (anything
         '(((name . "<span class="quote">test</span>")
            (init
             . (lambda () (with-current-buffer (anything-candidate-buffer 'global)
                            (erase-buffer)
                            (insert "<span class="quote">a\nb\n</span>"))))
            (candidates-in-buffer)
            (real-to-display . upcase)
            (action . identity))))
        (with-current-buffer (anything-buffer-get) (buffer-string)))
      (desc "<span class="quote">Symbols are acceptable as candidate.</span>")
      (expect '(("<span class="quote">test</span>" (sym "<span class="quote">str</span>")))
        (anything-test-candidates
         '(((name . "<span class="quote">test</span>")
            (candidates sym "<span class="quote">str</span>")))))
      (expect '(("<span class="quote">test</span>" ((sym . realsym) ("<span class="quote">str</span>" . "<span class="quote">realstr</span>"))))
        (anything-test-candidates
         '(((name . "<span class="quote">test</span>")
            (candidates (sym . realsym) ("<span class="quote">str</span>" . "<span class="quote">realstr</span>"))))))
      (expect '(("<span class="quote">test</span>" (sym)))
        (anything-test-candidates
         '(((name . "<span class="quote">test</span>")
            (candidates sym "<span class="quote">str</span>")))
         "<span class="quote">sym</span>"))
      (expect '(("<span class="quote">test</span>" ("<span class="quote">str</span>")))
        (anything-test-candidates
         '(((name . "<span class="quote">test</span>")
            (candidates sym "<span class="quote">str</span>")))
         "<span class="quote">str</span>"))
      (expect '(("<span class="quote">test</span>" ((sym . realsym))))
        (anything-test-candidates
         '(((name . "<span class="quote">test</span>")
            (candidates (sym . realsym) ("<span class="quote">str</span>" . "<span class="quote">realstr</span>"))))
         "<span class="quote">sym</span>"))
      (expect '(("<span class="quote">test</span>" (("<span class="quote">str</span>" . "<span class="quote">realstr</span>"))))
        (anything-test-candidates
         '(((name . "<span class="quote">test</span>")
            (candidates (sym . realsym) ("<span class="quote">str</span>" . "<span class="quote">realstr</span>"))))
         "<span class="quote">str</span>"))
      (desc "<span class="quote">multiple transformers</span>")
      (expect '(("<span class="quote">test</span>" ("<span class="quote">&lt;FOO&gt;</span>")))
        (anything-test-candidates
         '(((name . "<span class="quote">test</span>")
            (candidates "<span class="quote">foo</span>")
            (candidate-transformer
             . (lambda (cands)
                 (anything-compose (list cands)
                                   (list (lambda (c) (mapcar 'upcase c))
                                         (lambda (c) (list (concat "<span class="quote">&lt;</span>" (car c) "<span class="quote">&gt;</span>")))))))))))
      (expect '("<span class="quote">&lt;FOO&gt;</span>")
        (anything-composed-funcall-with-source
         '((name . "<span class="quote">test</span>"))
         (list (lambda (c) (mapcar 'upcase c))
               (lambda (c) (list (concat "<span class="quote">&lt;</span>" (car c) "<span class="quote">&gt;</span>"))))
         '("<span class="quote">foo</span>"))
        )
      (expect '(("<span class="quote">test</span>" ("<span class="quote">&lt;FOO&gt;</span>")))
        (anything-test-candidates
         '(((name . "<span class="quote">test</span>")
            (candidates "<span class="quote">foo</span>")
            (candidate-transformer
             (lambda (c) (mapcar 'upcase c))
             (lambda (c) (list (concat "<span class="quote">&lt;</span>" (car c) "<span class="quote">&gt;</span>"))))))))
      (expect '(("<span class="quote">test</span>" ("<span class="quote">&lt;BAR&gt;</span>")))
        (anything-test-candidates
         '(((name . "<span class="quote">test</span>")
            (candidates "<span class="quote">bar</span>")
            (filtered-candidate-transformer
             (lambda (c s) (mapcar 'upcase c))
             (lambda (c s) (list (concat "<span class="quote">&lt;</span>" (car c) "<span class="quote">&gt;</span>"))))))))
      (expect '(("<span class="quote">find-file</span>" . find-file)
                ("<span class="quote">view-file</span>" . view-file))
        (stub zerop =&gt; nil)
        (stub anything-get-current-source
              =&gt; '((name . "<span class="quote">test</span>")
                   (action)
                   (action-transformer
                    . (lambda (a s)
                        (anything-compose
                         (list a s)
                         (list (lambda (a s) (push '("<span class="quote">view-file</span>" . view-file) a))
                               (lambda (a s) (push '("<span class="quote">find-file</span>" . find-file) a))))))))
        (anything-get-action))
      (expect '(("<span class="quote">find-file</span>" . find-file)
                ("<span class="quote">view-file</span>" . view-file))
        (stub zerop =&gt; nil)
        (stub anything-get-current-source
              =&gt; '((name . "<span class="quote">test</span>")
                   (action)
                   (action-transformer
                    (lambda (a s) (push '("<span class="quote">view-file</span>" . view-file) a))
                    (lambda (a s) (push '("<span class="quote">find-file</span>" . find-file) a)))))
        (anything-get-action))
      (desc "<span class="quote">define-anything-type-attribute</span>")
      (expect '((file (action . find-file)))
        (let (anything-type-attributes)
          (define-anything-type-attribute 'file '((action . find-file)))
          anything-type-attributes))
      (expect '((file (action . find-file)))
        (let ((anything-type-attributes '((file (action . view-file)))))
          (define-anything-type-attribute 'file '((action . find-file)))
          anything-type-attributes))
      (expect '((file (action . find-file))
                (buffer (action . switch-to-buffer)))
        (let (anything-type-attributes)
          (define-anything-type-attribute 'buffer '((action . switch-to-buffer)))
          (define-anything-type-attribute 'file '((action . find-file)))
          anything-type-attributes))
      )))


(provide 'anything)
<span class="linecomment">;; How to save (DO NOT REMOVE!!)</span>
<span class="linecomment">;; (emacswiki-post "anything.el")</span>
<span class="linecomment">;;; anything.el ends here</span></span></pre></div><div class="wrapper close"></div></div><div class="footer"><hr /><span class="gotobar bar"><a class="local" href="http://www.emacswiki.org/emacs/SiteMap">SiteMap</a> <a class="local" href="http://www.emacswiki.org/emacs/Search">Search</a> <a class="local" href="http://www.emacswiki.org/emacs/ElispArea">ElispArea</a> <a class="local" href="http://www.emacswiki.org/emacs/HowTo">HowTo</a> <a class="local" href="http://www.emacswiki.org/emacs/RecentChanges">RecentChanges</a> <a class="local" href="http://www.emacswiki.org/emacs/News">News</a> <a class="local" href="http://www.emacswiki.org/emacs/Problems">Problems</a> <a class="local" href="http://www.emacswiki.org/emacs/Suggestions">Suggestions</a> </span><span class="translation bar"><br />  <a class="translation new" rel="nofollow" href="http://www.emacswiki.org/emacs?action=translate;id=anything.el;missing=de_es_fr_it_ja_ko_pt_ru_se_zh">Add Translation</a></span><span class="edit bar"><br /> <a class="edit" accesskey="e" title="Click to edit this page" rel="nofollow" href="http://www.emacswiki.org/emacs?action=edit;id=anything.el">Edit this page</a> <a class="history" rel="nofollow" href="http://www.emacswiki.org/emacs?action=history;id=anything.el">View other revisions</a> <a class="admin" rel="nofollow" href="http://www.emacswiki.org/emacs?action=admin;id=anything.el">Administration</a></span><span class="time"><br /> Last edited 2009-08-08 13:25 UTC by <a class="author" title="from 124-144-92-34.rev.home.ne.jp" href="http://www.emacswiki.org/emacs/rubikitch">rubikitch</a> <a class="diff" rel="nofollow" href="http://www.emacswiki.org/emacs?action=browse;diff=2;id=anything.el">(diff)</a></span><div style="float:right; margin-left:1ex;">
<!-- Creative Commons License -->
<a href="http://creativecommons.org/licenses/GPL/2.0/"><img alt="CC-GNU GPL" style="border:none" src="/pics/cc-GPL-a.png" /></a>
<!-- /Creative Commons License -->
</div>

<!--
<rdf:RDF xmlns="http://web.resource.org/cc/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<Work rdf:about="">
   <license rdf:resource="http://creativecommons.org/licenses/GPL/2.0/" />
  <dc:type rdf:resource="http://purl.org/dc/dcmitype/Software" />
</Work>

<License rdf:about="http://creativecommons.org/licenses/GPL/2.0/">
   <permits rdf:resource="http://web.resource.org/cc/Reproduction" />
   <permits rdf:resource="http://web.resource.org/cc/Distribution" />
   <requires rdf:resource="http://web.resource.org/cc/Notice" />
   <permits rdf:resource="http://web.resource.org/cc/DerivativeWorks" />
   <requires rdf:resource="http://web.resource.org/cc/ShareAlike" />
   <requires rdf:resource="http://web.resource.org/cc/SourceCode" />
</License>
</rdf:RDF>
-->

<p class="legal">
This work is licensed to you under version 2 of the
<a href="http://www.gnu.org/">GNU</a> <a href="/GPL">General Public License</a>.
Alternatively, you may choose to receive this work under any other
license that grants the right to use, copy, modify, and/or distribute
the work, as long as that license imposes the restriction that
derivative works have to grant the same rights and impose the same
restriction. For example, you may choose to receive this work under
the
<a href="http://www.gnu.org/">GNU</a>
<a href="/FDL">Free Documentation License</a>, the
<a href="http://creativecommons.org/">CreativeCommons</a>
<a href="http://creativecommons.org/licenses/sa/1.0/">ShareAlike</a>
License, the XEmacs manual license, or
<a href="/OLD">similar licenses</a>.
</p>
</div>
</body>
</html>
