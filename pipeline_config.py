from moduleultra.pipeline_config_utils import *
from packagemega import Repo as PMRepo
from packagemega.mini_language import processOperand
from sys import stderr

pipeDir = fromPipelineDir('')
pmrepo = PMRepo.loadRepo()


def scriptDir(fpath):
    dname = pipeDir + '/scripts/'
    return dname + fpath


def pmegaDB(operand):
    try:
        res = processOperand(pmrepo, operand, stringify=True)
    except KeyError:
        stderr.write('[packagemega] {} not found.\n'.format(operand))
        res = ''
    return res


def which(tool):
    cmd = 'which {}'.format(tool)
    return resolveCmd(cmd)


config = {
    'bt2': {
        'exc': {
            'filepath': which('bowtie2'),
            'version': resolveCmd('bowtie2 --version')
        }
    },
    'filter_human_dna': {
        'db': {
            'filepath': pmegaDB('hg38_ucsc.bt2.prefix')
        },
        'threads': 6,
        'time': 10,
        'ram': 10
    },
    'samtools': {
        'filepath': which('samtools')
    },
    'python2': which('python2'),
    'adapter_removal': {
        'time': 5,
        'threads': 6,
        'ram': 10,
        'exc': {
            'filepath': which('AdapterRemoval'),
            'version': resolveCmd('AdapterRemoval --version 2>&1')
        }
    }
}
