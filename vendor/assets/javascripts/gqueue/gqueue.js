/**
 * GQueue
 * Fixed size FIFO queue class providing associative access. Can also be used as a Circular Buffer.
 * @author  Geoffray Warnants <http://www.geoffray.be>
 * @version 1.3.20120427
 */

/**
 * Creates an empty queue
 * @param {int} maxlength
 * @param {Boolean} circular If true, the queue as will be defined as a "Circular Buffer".
 * @constructor
 */
function GQueue(size, circular) {
    if (!(this instanceof GQueue)) {
        return new GQueue(size, circular);
    }
    this.data = {};
    this.circular = Boolean(circular);
    this.maxlength = parseInt(size, 10);
    if (isNaN(this.maxlength)) {
        this.maxlength = 0;
    }
    this.length = 0;
}
GQueue.prototype = {
    /**
     * Adds new element to the end of the queue
     * @param {String}  k   Key
     * @param {Object}  v   Value
     * @return {int}    The new length, or -1 if the queue is full
     */
    push: function (k, v) {
        if (typeof this.data[k] === "undefined") {
            if (this.length < this.maxlength) {
                this.length++;
            } else if (this.circular) {
                this.pop();
                this.length++;
            } else {
                return -1;
            }
        }
        this.data[k] = v;
        return this.length;
    },
    /**
     * Removes the last element of the queue
     * @return {Object}    The removed element, or null if none.
     */
    pop: function () {
        for (var i in this.data) {
            var value = this.data[i];
            delete this.data[i];
            this.length--;
            return value;
        }
        return null;
    },
    /**
     * Checks if a key exists in the queue.
     * @param {String}  k   Searched key
     * @return {Boolean}
     */
    has: function (k) {
        return typeof this.data[k] !== "undefined";
    },
    /**
     * Searches an element for a given key
     * @param {String} k  Searched key
     * @return {Object}    The found element, or null if none.
     */
    find: function (k) {
        return (typeof this.data[k] !== "undefined") ? this.data[k] : null;
    },
    /**
     * Unset an element for a given key
     * @param {String}  k   Element key
     * @return {Void}
     */
    unset: function (k) {
        if (typeof this.data[k] !== "undefined") {
            delete this.data[k];
            this.length--;
        }
    },
    /**
     * Clear all elements
     * @return {Void}
     */
    clear: function () {
        this.data = {};
        this.length = 0;
    }
};
