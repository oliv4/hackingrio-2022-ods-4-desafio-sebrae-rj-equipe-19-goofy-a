import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { CompaniesEntity } from './companies.entity';
import { CompaniesRepository } from './companies.repository';
@Injectable()
export class CompaniesService {
  constructor(
    @InjectRepository(CompaniesRepository)
    private readonly companiesRepository: CompaniesRepository,
  ) {}

  public async findById(id: string): Promise<CompaniesEntity> {
    const company = await this.companiesRepository.findById(id);
    if (!company)
      throw new NotFoundException('Was not possible to find this company');
    return company;
  }
}
