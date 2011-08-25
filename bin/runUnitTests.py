#!/usr/bin/env python
#######################################################
# Script that runs all unit tests.
#
# This script 
# - creates temporary directories for each processors, 
# - copies the directory 'Buildings' into these
#   temporary directories,
# - creates run scripts that run all unit tests,
# - runs these unit tests,
# - collects the dymola log files from each process,
# - writes the combined log file 'unitTests.log'
#   in the current directory, 
# - checks the md5sum of the .mat files versus the number
#   that is stored in Buildings/../md5sum, and
# - exits with the message 
#    'Unit tests completed successfully.' or with
#   an error message.
#
# If no errors occurred during the unit tests, then
# this script returns 0. Otherwise, it returns a
# non-zero exit value.
#
# MWetter@lbl.gov                            2011-02-23
#######################################################
import buildingspy.development.unittest as u
import getopt
import sys

def usage():
    ''' Print the usage statement
    '''
    print "runUnitTests.py [-b|-h|--help]"
    print ""
    print "  Runs the unit tests."
    print ""
    print "  -b         Batch mode, without user interaction"
    print "  -h, --help Print this help"
    print ""

if __name__ == '__main__':
    batch = False

    try:
        opts, args=getopt.getopt(sys.argv[1:], "hb", ["help", "batch"])
    except getopt.GetoptError, err:
        print str(err)
        usage()
        sys.exit(2)

    for o, a in opts:
        if (o == "-b" or o == "--batch"):
            batch=True
            print "Running in batch mode."
        elif (o == "-h" or o == "--help"):
            usage()
            sys.exit()
        else:
            assert False, "Unhandled option."

    ut = u.Tester()
    ut.batchMode(batch)
#    ut.setNumberOfThreads(1)
#    ut.deleteTemporaryDirectories(False)
#    ut.useExistingResults(['/tmp/tmp-Buildings-0-TgauLl'])
#    #print ut.getDataDictionary()
    ut.run()
